//
//  TicketRecordViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TicketRecordViewController.h"
#import "TastTop.h"
#import "TicketRecordSectionHeader.h"
#import "TicketRecordCell.h"
#import "TicketRecordModel.h"
#import "NoDataView.h"

@interface TicketRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TastTop *topView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;
@property(nonatomic,assign)int totalpage;
@property(nonatomic,assign)int currentpage;
@end

@implementation TicketRecordViewController

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
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor blackColor]};
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kThemeColor;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
}
-(NoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView=[[NoDataView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 200)];
        
        [self.view addSubview:self.noDataView];
    }
    return _noDataView;
}
-(void)getNewData{
    _page=1;
    [self.dataArr removeAllObjects];
    
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
    
    [TDHttpTools ticketRecordWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                TicketRecordModel *model=[[TicketRecordModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            self.totalpage=[dic[@"data"][@"totalpage"] intValue];
            self.currentpage=[dic[@"data"][@"currentpage"] intValue];
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
-(void)getMoreData{
    _page=_page+1;
    if (_page>_totalpage) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        return;
    }
    NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
    [TDHttpTools ticketRecordWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                TicketRecordModel *model=[[TicketRecordModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            self.totalpage=[dic[@"data"][@"totalpage"] intValue];
            self.currentpage=[dic[@"data"][@"currentpage"] intValue];
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
    self.title=@"车票记录";
    self.view.backgroundColor=kBackgroundColor;
    
    self.topView=[[TastTop alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 87)];
    self.topView.ticketCount.text=[NSString stringWithFormat:@"%d",self.ticketCount];
    [self.topView setCenterClickBlock:^{
        NSLog(@"兑换中心");
    }];
    [self.view addSubview:self.topView];
    
    
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, kScreenWidth, kTableViewHeight-self.topView.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TicketRecordModel *model=self.dataArr[section];
    
    return model.records.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellID";
    TicketRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[TicketRecordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        cell.separatorInset=UIEdgeInsetsMake(0, 12, 0, 12);
    }
    TicketRecordModel *model=self.dataArr[indexPath.section];
    NSArray *arr=model.records;
    NSDictionary *dic=arr[indexPath.row];
    cell.leftLab.text=dic[@"title"];
    cell.rightLab.text=[NSString stringWithFormat:@"+%@",dic[@"score"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TicketRecordSectionHeader *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (header==nil) {
        header=[[TicketRecordSectionHeader alloc]initWithReuseIdentifier:@"headerView"];
        
    }
    TicketRecordModel *model=self.dataArr[section];
    header.timeLab.text=model.day;
    return header;
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
