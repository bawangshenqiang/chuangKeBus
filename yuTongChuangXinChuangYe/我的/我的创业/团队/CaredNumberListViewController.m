//
//  CaredNumberListViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CaredNumberListViewController.h"
#import "CaredNumberListCell.h"
#import "CaredNumberListModel.h"

@interface CaredNumberListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;

@end

@implementation CaredNumberListViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getNewData{
    _page=1;
    
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"teamId":@(self.teamId)};
    
    [self.dataArr removeAllObjects];
    [TDHttpTools caredNumberListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                CaredNumberListModel *model=[[CaredNumberListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)getMoreData{
    _page=_page+1;
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"teamId":@(self.teamId)};
    [TDHttpTools caredNumberListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                CaredNumberListModel *model=[[CaredNumberListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    
    [self.view addSubview:self.tableView];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID3=@"cellID3";
    CaredNumberListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID3];
    if (!cell) {
        cell=[[CaredNumberListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID3];
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.indexPath=indexPath;
    cell.model=self.dataArr[indexPath.section];
    
    WS(weakSelf);
    [cell setTeleBtnBlock:^(NSString * _Nonnull telephone) {
        [weakSelf clickTelephone:telephone];
    }];
    [cell setLookAllBtnBlock:^(NSIndexPath *indexPath){
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    if (self.dataArr.count>0) {
        CaredNumberListModel *model=self.dataArr[indexPath.section];
        height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CaredNumberListCell class] contentViewWidth:kScreenWidth];
    }
    
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}

-(void)clickTelephone:(NSString *)telephone{
    //NSLog(@"打电话");
    if (telephone.length==11) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", telephone];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
