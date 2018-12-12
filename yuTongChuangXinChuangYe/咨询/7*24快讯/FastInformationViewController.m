//
//  FastInformationViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "FastInformationViewController.h"
#import "FastInfoListModel.h"
#import "FastInforListCell.h"

@interface FastInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation FastInformationViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getData{
//    NSArray *arr=@[@{@"title":@"PayPal总裁：我们将每年准备30亿美元用于收购，富士康二季度收益低于预期",@"detailTitle":@"8月14日据国外媒体报道，特斯拉大股东之一富达基金第二季度将其持有的特斯拉公司股票比例降低了21%。此前，特斯拉首席执行官埃隆马斯克（Elon Musk）在本月稍早时候宣布自己计划将公司私有化。",@"times":@"07:54",@"fromStr":@"腾讯科技"},@{@"title":@"PayPal总裁：我们将每年准备30亿美元用于收购，富士康二季度收益低于预期",@"detailTitle":@"8月14日据国外媒体报道，特斯拉大股东之一富达基金第二季度将其持有的特斯拉公司股票比例降低了21%。此前，特斯拉首席执行官埃隆马斯克（Elon Musk）在本月稍早时候宣布自己计划将公司私有化。",@"times":@"07:54",@"fromStr":@"腾讯科技"},@{@"title":@"PayPal总裁：我们将每年准备30亿美元用于收购，富士康二季度收益低于预期",@"detailTitle":@"8月14日据国外媒体报道，特斯拉大股东之一富达基金第二季度将其持有的特斯拉公司股票比例降低了21%。此前，特斯拉首席执行官埃隆马斯克（Elon Musk）在本月稍早时候宣布自己计划将公司私有化。",@"times":@"07:54",@"fromStr":@"腾讯科技"},@{@"title":@"PayPal总裁：我们将每年准备30亿美元用于收购，富士康二季度收益低于预期",@"detailTitle":@"8月14日据国外媒体报道，特斯拉大股东之一富达基金第二季度将其持有的特斯拉公司股票比例降低了21%。此前，特斯拉首席执行官埃隆马斯克（Elon Musk）在本月稍早时候宣布自己计划将公司私有化。",@"times":@"07:54",@"fromStr":@"腾讯科技"}];
//    for (NSDictionary *dic in arr) {
//        FastInfoListModel *model=[[FastInfoListModel alloc]initWithDictionary:dic];
//        [self.dataArr addObject:model];
//    }
//    [self.tableView reloadData];
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token};
    [TDHttpTools fastInformationListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"flash"]) {
                FastInfoListModel *model=[[FastInfoListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            if (self.dataArr.count>0) {
                FastInfoListModel *model=self.dataArr[0];
                model.showBottomView=YES;
                [self.dataArr replaceObjectAtIndex:0 withObject:model];
            }
            [self.tableView reloadData];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
    self.view. backgroundColor=kBackgroundColor;
    self.title=@"7*24小时快讯";
    [self.view addSubview:self.tableView];
    [self getData];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        //_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellIdentifier";
    FastInforListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[FastInforListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsMake(0, 35, 0, 10);
    }
    cell.indexPath=indexPath;
    FastInfoListModel *model=self.dataArr[indexPath.row];
    cell.model=model;
    
    WS(weakSelf);
    [cell setFlodClickBlock:^(NSIndexPath * _Nonnull indexPath) {
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    [cell setShareClickBlock:^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击分享按钮%d",(int)indexPath.row);
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    FastInfoListModel *model=self.dataArr[indexPath.row];
    height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[FastInforListCell class] contentViewWidth:kScreenWidth-20];
    return height;
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
