//
//  ClientDemandListViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ClientDemandListViewController.h"
#import "ClientDemandListModel.h"
#import "ClientDemandListCell.h"
#import "ServerDetailViewController.h"
#import "NoDataView.h"
#import "ServeProgressViewController.h"

@interface ClientDemandListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISegmentedControl *topSegment;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;
@end

@implementation ClientDemandListViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(NoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView=[[NoDataView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 200)];
        
        [self.view addSubview:self.noDataView];
    }
    return _noDataView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)getNewData:(int)status{
    _page=1;
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"status":@(status)};
    [TDHttpTools clientDemandListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                ClientDemandListModel *model=[[ClientDemandListModel alloc]initWithDictionary:dict];
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
-(void)getMoreData:(int)status{
    _page=_page+1;
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"status":@(status)};
    [TDHttpTools clientDemandListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                ClientDemandListModel *model=[[ClientDemandListModel alloc]initWithDictionary:dict];
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
    self.view .backgroundColor=kBackgroundColor;
    self.title=@"客户需求";
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的店铺" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    //
    NSArray *topSegmentTitle=@[@"待回复",@"服务中",@"服务完成"];
    self.topSegment=[[UISegmentedControl alloc]initWithItems:topSegmentTitle];
    self.topSegment.frame=CGRectMake(0, 0, kScreenWidth, 40);
    self.topSegment.backgroundColor=kBackgroundColor;
    self.topSegment.tintColor=[UIColor clearColor];
    [self.topSegment setSelectedSegmentIndex:0];
    NSDictionary *textAttributes1=[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   [UIFont systemFontOfSize:18], NSFontAttributeName,
                                   nil];
    [self.topSegment setTitleTextAttributes:textAttributes1 forState:UIControlStateNormal];
    
    NSDictionary *textAttributes2=[NSDictionary dictionaryWithObjectsAndKeys:
                                   kThemeColor, NSForegroundColorAttributeName,
                                   [UIFont systemFontOfSize:18], NSFontAttributeName,
                                   nil];
    [self.topSegment setTitleTextAttributes:textAttributes2 forState:UIControlStateSelected];
    [self.topSegment addTarget:self action:@selector(topSelecte:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.topSegment];
    //
    UIView *segmentBottomLine=[[UIView alloc]initWithFrame:CGRectMake(0, self.topSegment.bottom-2, 60, 2)];
    segmentBottomLine.center=CGPointMake(kScreenWidth/6, segmentBottomLine.centerY);
    segmentBottomLine.backgroundColor=kThemeColor;
    segmentBottomLine.tag=33333;
    [self.view addSubview:segmentBottomLine];
    //
    [self.view addSubview:self.tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
         [weakSelf getNewData:(int)weakSelf.topSegment.selectedSegmentIndex];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreData:(int)weakSelf.topSegment.selectedSegmentIndex];
        
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)rightBarButtonClick{
    //服务商详情
    ServerDetailViewController *detailVC=[ServerDetailViewController new];
    detailVC.providerId=[Account sharedAccount].providerId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)topSelecte:(UISegmentedControl *)segment{
    UIView *view=[self.view viewWithTag:33333];
    switch (self.topSegment.selectedSegmentIndex) {
        case 0:
        {
            view.center=CGPointMake(kScreenWidth/6, view.centerY);
        }
            break;
        case 1:
        {
            view.center=CGPointMake(kScreenWidth/2, view.centerY);
        }
            break;
        default:
        {
            view.center=CGPointMake(kScreenWidth*5/6, view.centerY);
            
        }
            break;
    }
    [self getNewData:(int)self.topSegment.selectedSegmentIndex];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.topSegment.bottom, kScreenWidth, kTableViewHeight-40) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellID";
    ClientDemandListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[ClientDemandListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=kBackgroundColor;
    }
    if (self.dataArr.count>0) {
        cell.model=self.dataArr[indexPath.row];
        WS(weakSelf);
        [cell setTeleBtnBlock:^(NSString * _Nonnull telephone) {
            [weakSelf clickTelephone:telephone];
        }];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    if (self.dataArr.count>0) {
        ClientDemandListModel *model=self.dataArr[indexPath.row];
        height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ClientDemandListCell class] contentViewWidth:kScreenWidth];
    }
    
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    ClientDemandListModel *model=self.dataArr[indexPath.row];
    ServeProgressViewController *detailVC=[ServeProgressViewController new];
    detailVC.providerId=model.providerId;
    detailVC.demandId=model.Id;
    detailVC.userId=model.userId;
    detailVC.title=@"需求详情";
    detailVC.isUser=NO;
    [self.navigationController pushViewController:detailVC animated:YES];
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
