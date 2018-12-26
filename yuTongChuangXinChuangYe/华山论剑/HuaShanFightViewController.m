//
//  HuaShanFightViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanFightViewController.h"
#import "CustomNavi.h"
#import "TableHeader_HuaShanFirst.h"
#import "HuaShanListModel.h"
#import "HuaShanCell_First.h"
#import "SectionHeader_HallFirst.h"
#import "SystemHallViewController.h"
#import "MyMessageViewController.h"
#import "HuaShanDetailViewController.h"
#import "SearchViewController.h"

#import "HuaShanTitleCell_HallFirst.h"
#import "Header_HuaShan.h"
#import "LoginViewController.h"
#import "PublishThemeViewController.h"

extern BOOL receiveMessage;

@interface HuaShanFightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomNavi *customNavi;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *themeArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)Header_HuaShan *headView;

@end

@implementation HuaShanFightViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)themeArr{
    if (!_themeArr) {
        _themeArr=[NSMutableArray array];
    }
    return _themeArr;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if (receiveMessage) {
        self.customNavi.redDot.hidden=NO;
    }else{
        self.customNavi.redDot.hidden=YES;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
//-(void)getData{
//    NSArray *arr=@[@{@"headerUrl":@"",@"name":@"腾顺娟娟",@"time":@"20分钟前",@"title":@"这家公司要用设计+AI创造新时代！",@"subtitle":@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务",@"bigImgUrl":@"",@"comment":@(24132),@"praise":@(1234)},@{@"headerUrl":@"",@"name":@"腾顺娟娟",@"time":@"20分钟前",@"title":@"这家公司要用设计+AI创造新时代！",@"subtitle":@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务",@"bigImgUrl":@"",@"comment":@(24132),@"praise":@(1234)},@{@"headerUrl":@"",@"name":@"腾顺娟娟",@"time":@"20分钟前",@"title":@"这家公司要用设计+AI创造新时代！",@"subtitle":@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务",@"bigImgUrl":@"",@"comment":@(24132),@"praise":@(1234)}];
//    for (NSDictionary *dic in arr) {
//        HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dic];
//        [self.dataArr addObject:model];
//    }
//    [self.tableView reloadData];
//
//}
-(void)getNewData{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token};
    [TDHttpTools huaShanHomepageWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"recpost"][@"records"]) {
                HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            self.themeArr=dic[@"data"][@"themes"];
            self.headView.titleArr=self.themeArr;
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
    [TDHttpTools huaShanHomepageWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",dic);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"recpost"][@"records"]) {
                HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dict];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    
    //
    self.customNavi=[[CustomNavi alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+44)];
    
    WS(weakSelf);
    [self.customNavi setTouchSearchBlock:^{
        NSLog(@"点击搜索");
        SearchViewController *searchVC=[[SearchViewController alloc]init];
        
        [weakSelf.navigationController pushViewController:searchVC animated:YES];
    }];
    [self.customNavi setTouchMessageBlock:^{
        NSLog(@"点击消息");
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            weakSelf.customNavi.redDot.hidden=YES;
            receiveMessage=NO;
            [Account sharedAccount].message=0;
            MyMessageViewController *messageVC=[MyMessageViewController new];
            messageVC.index=0;
            [weakSelf.navigationController pushViewController:messageVC animated:YES];
        }
    }];
    [self.view addSubview:self.customNavi];
    
    [self.view addSubview:self.headView];
    [self.headView setTopSegmentChangeBlock:^(int index) {
        
        NSDictionary *dic=weakSelf.themeArr[index];
        //NSLog(@"%@",dic[@"name"]);
        SystemHallViewController *systemVC=[SystemHallViewController new];
        systemVC.title=dic[@"name"];
        systemVC.themeId=[dic[@"id"] intValue];
        systemVC.themeArr=weakSelf.themeArr;
        
        [weakSelf.navigationController pushViewController:systemVC animated:YES];
    }];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewData];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{//MJRefreshBackFooter
        
        [weakSelf getMoreData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(kScreenWidth-75, self.tableView.bottom-75, 50, 50);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"huashan_publish"] forState:UIControlStateNormal];
    submitBtn.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    submitBtn.layer.shadowOffset=CGSizeMake(0, 3);
    submitBtn.layer.shadowRadius=3;
    submitBtn.layer.shadowOpacity=1;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
}
-(void)submitClick{
    //NSLog(@"发表主题");
    if ([Account sharedAccount]==nil) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNavi animated:YES completion:nil];
    }else{
        PublishThemeViewController *publishVC=[PublishThemeViewController new];
        publishVC.themeArr=self.themeArr;
        [self.navigationController pushViewController:publishVC animated:YES];
    }
    
}
-(Header_HuaShan *)headView{
    if (!_headView) {
        _headView=[[Header_HuaShan alloc]init];
        _headView.frame=CGRectMake(0, self.customNavi.bottom, kScreenWidth, 80);
    }
    return _headView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.bottom+10, kScreenWidth, kScreenHeight-self.customNavi.height-kTabBarHeight-90) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //_tableView.tableHeaderView=[self header];
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(UIView *)header{
//    TableHeader_HuaShanFirst *header=[[TableHeader_HuaShanFirst alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60*kBaseHeight)];
//    WS(weakSelf);
//    [header setFourBtnClickBlock:^(NSInteger index) {
//        //系统大厅，行业交流，综合讨论，意见反馈
//        NSLog(@"tag:%ld",(long)index);
//        switch (index-700) {
//            case 0:
//            {
//                SystemHallViewController *systemVC=[SystemHallViewController new];
//                [weakSelf.navigationController pushViewController:systemVC animated:YES];
//            }
//
//                break;
//            case 1:
//
//                break;
//            case 2:
//
//                break;
//            default:
//
//                break;
//        }
//    }];
//    return header;
    
    Header_HuaShan *header=[[Header_HuaShan alloc]init];
    self.headView=header;
    self.headView.frame=CGRectMake(0, 0, kScreenWidth, 80*kBaseHeight);
    WS(weakSelf);
    [self.headView setTopSegmentChangeBlock:^(int index) {
        
        NSDictionary *dic=weakSelf.themeArr[index];
        //NSLog(@"%@",dic[@"name"]);
        SystemHallViewController *systemVC=[SystemHallViewController new];
        //systemVC.title=dic[@"name"];
        systemVC.name=dic[@"name"];
        systemVC.themeId=[dic[@"id"] intValue];
        systemVC.themeArr=weakSelf.themeArr;
        
        [weakSelf.navigationController pushViewController:systemVC animated:YES];
    }];
    return header;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *cellID=@"cellIdentifier";
//    HuaShanCell_First *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell=[[HuaShanCell_First alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//        cell.backgroundColor=[UIColor whiteColor];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
//    cell.model=self.dataArr[indexPath.row];
//    return cell;
    static NSString *cellId2=@"cellIdentifier2";
    HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
    if (!cell) {
        cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (self.dataArr.count>0) {
        HuaShanListModel *model=self.dataArr[indexPath.row];
        cell.model=model;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HuaShanListModel *model=self.dataArr[indexPath.row];
//    CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanCell_First class] contentViewWidth:kScreenWidth];
//    return height;
    HuaShanListModel *model=self.dataArr[indexPath.row];
    CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
    }
    NSArray *images=@[@"hall_hottest"];
    NSArray *titles=@[@"热门主题"];
    header.leftIV.image=[UIImage imageNamed:images[section]];
    header.titleLab.text=titles[section];
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
    HuaShanListModel *model=self.dataArr[indexPath.row];
    detailVC.postId=model.Id;
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
