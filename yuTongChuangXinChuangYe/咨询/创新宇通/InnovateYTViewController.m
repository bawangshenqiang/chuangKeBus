//
//  InnovateYTViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InnovateYTViewController.h"
#import "OnlyOneImageCell.h"
#import "InformationListCell.h"
#import "DetailViewController.h"
#import "InformationListModel.h"

@interface InnovateYTViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSDictionary *imageDic;

@end

@implementation InnovateYTViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getNewData{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token};
    [TDHttpTools innovationListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            self.imageDic=dic[@"data"][@"carousels"];
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
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token};
    [TDHttpTools innovationListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
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
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"创新宇通";
    self.view.backgroundColor=kBackgroundColor;
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString *cellId1=@"cellIdentifier1";
        OnlyOneImageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId1];
        if (!cell) {
            cell=[[OnlyOneImageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell.oneIV sd_setImageWithURL:[NSURL URLWithString:self.imageDic[@"cover"]] placeholderImage:[UIImage imageNamed:@"listing"]];
        return cell;
    }else{
        NSString *cellId=@"cellIdentifier";
        InformationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[InformationListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (self.dataArr.count>0) {
            cell.model=self.dataArr[indexPath.row-1];
        }
        
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 130;
    }
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC=[DetailViewController new];
    if (indexPath.row==0) {
        detailVC.innovationId=[self.imageDic[@"id"] intValue];
    }else{
        InformationListModel *model=self.dataArr[indexPath.row-1];
        detailVC.innovationId=model.Id;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
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
