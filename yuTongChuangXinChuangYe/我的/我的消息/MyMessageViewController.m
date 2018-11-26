//
//  MyMessageViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MyMessageViewController.h"
#import "Head_BusinessCourse.h"
#import "SystemMessageCell.h"
#import "UserMessageCell.h"
#import "SystemMessageModel.h"
#import "UserMessageModel.h"
#import "NoDataView.h"
#import "HuaShanDetailViewController.h"
#import "ServerDetailViewController.h"
#import "SearchNumbersDetailViewController.h"
#import "CreativityAndProjectDetailViewController.h"
#import "DetailViewController.h"
#import "BusinessHotDetailViewController.h"
#import "SystemMessageDetailViewController.h"

@interface MyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;
@end

@implementation MyMessageViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
-(NoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView=[[NoDataView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 200)];
        
        [self.view addSubview:self.noDataView];
    }
    return _noDataView;
}
-(void)getNewDataWith:(NSInteger)index{
    _page=1;
    [self.dataArr removeAllObjects];
    switch (index) {
        case 0:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            
            [TDHttpTools mySystemMessageWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        SystemMessageModel *model=[[SystemMessageModel alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                    
                }else{
                    [SJTool showAlertWithText:dic[@"msg"]];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
                });
                if (self.dataArr.count<=0) {
                    self.noDataView.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [self.tableView.mj_header endRefreshing];
            }];
            
        }
            break;
        case 1:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            
            [TDHttpTools myUserMessageWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        UserMessageModel *model=[[UserMessageModel alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
                    }
                    
                }else{
                    [SJTool showAlertWithText:dic[@"msg"]];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                    [self.tableView reloadData];
                });
                if (self.dataArr.count<=0) {
                    self.noDataView.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [self.tableView.mj_header endRefreshing];
            }];
            
        }
            break;
    }
    [self.tableView reloadData];
}
-(void)getMoreDataWith:(NSInteger)index{
    _page=_page+1;
    switch (index) {
        case 0:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools mySystemMessageWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        SystemMessageModel *model=[[SystemMessageModel alloc]initWithDictionary:dict];
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
            break;
            
        default:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools myUserMessageWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        UserMessageModel *model=[[UserMessageModel alloc]initWithDictionary:dict];
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
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"我的消息";
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    self.header.selectedIndex=self.index;
    self.header.fixedTitles=@[@"系统消息",@"个人消息"];
    WS(weakSelf);
    [self.header setTopSegmentChangeBlock:^(int index) {
        NSLog(@"index=%d",index);
        
        [weakSelf topHeadSelectClick:index];
    }];
    [self.view addSubview:self.header];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewDataWith:(int)weakSelf.index];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreDataWith:(int)weakSelf.index];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
}
-(void)topHeadSelectClick:(int)index{
    self.index=index;
    
    [self getNewDataWith:index];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom, kScreenWidth, kTableViewHeight-40) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.index) {
        case 0:
        {
            NSString *cellID=@"cellIdentifier1";
            SystemMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[SystemMessageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellID=@"cellIdentifier2";
            UserMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[UserMessageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (self.index) {
        case 0:
        {
            SystemMessageModel *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SystemMessageCell class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        case 1:
        {
            UserMessageModel *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[UserMessageCell class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        default:
            break;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index==0) {
        SystemMessageModel *model=self.dataArr[indexPath.row];
        if (model.url.length) {
            SystemMessageDetailViewController *detailVC=[SystemMessageDetailViewController new];
            detailVC.urlString=model.url;
            detailVC.title=@"消息详情";
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }else{
        UserMessageModel *model=self.dataArr[indexPath.row];
        [self jumpWithId:model.targetId module:model.module];
    }
}
-(void)jumpWithId:(int)targetId module:(NSString *)module{
    if ([module isEqualToString:@"idea"]||[module isEqualToString:@"ideacollect"]||[module isEqualToString:@"ideapraise"]||[module isEqualToString:@"ideacomment"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=0;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"project"]||[module isEqualToString:@"projectcollect"]||[module isEqualToString:@"projectpraise"]||[module isEqualToString:@"projectcomment"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=1;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"findteamuser"]||[module isEqualToString:@"findteamusercare"]||[module isEqualToString:@"findteamuserpraise"]){
        SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"provider"]||[module isEqualToString:@"providercollect"]||[module isEqualToString:@"providerdemand"]){
        ServerDetailViewController *detailVC=[ServerDetailViewController new];
        detailVC.providerId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"post"]||[module isEqualToString:@"postcollect"]||[module isEqualToString:@"postpraise"]||[module isEqualToString:@"postcomment"]){
        HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
        detailVC.postId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
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
