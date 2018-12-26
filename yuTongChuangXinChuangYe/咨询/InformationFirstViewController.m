//
//  InformationFirstViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InformationFirstViewController.h"
#import "CustomNavi.h"
#import "TableHeader_InformationFirst.h"
#import "SectionHeader_HallFirst.h"
#import "InformationListCell.h"
#import "BusinessHotViewController.h"
#import "NewPolicyViewController.h"
#import "InnovateYTViewController.h"
#import "FastInformationViewController.h"
#import "MyMessageViewController.h"
#import "BusinessHotDetailViewController.h"
#import "SearchViewController.h"
#import "InformationListModel.h"
#import "LoginViewController.h"

extern BOOL receiveMessage;

@interface InformationFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CustomNavi *customNavi;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)TableHeader_InformationFirst *header;

@property(nonatomic,strong)NSMutableArray *tuiJianData;
@property(nonatomic,strong)NSMutableArray *newestData;
@property(nonatomic,assign)int page;
@end

@implementation InformationFirstViewController


-(NSMutableArray *)tuiJianData{
    if (!_tuiJianData) {
        _tuiJianData=[NSMutableArray array];
    }
    return _tuiJianData;
}
-(NSMutableArray *)newestData{
    if (!_newestData) {
        _newestData=[NSMutableArray array];
    }
    return _newestData;
}
-(void)getNewData{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"page":@(_page),@"size":@(10)};
    [TDHttpTools informationHomeWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        [self.tuiJianData removeAllObjects];
        [self.newestData removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            
            for (NSDictionary *dict in dic[@"data"][@"hotInformation"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.tuiJianData addObject:model];
            }
            for (NSDictionary *dict in dic[@"data"][@"newinformation"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.newestData addObject:model];
            }
            NSArray *imageArr=dic[@"data"][@"carousels"];
            if (imageArr.count>0) {
                self.header.topImage=imageArr.firstObject;
            }
            self.header.hot_24.titles=[dic[@"data"][@"twentyFourInformation"] mutableCopy];
            
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
    
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"page":@(_page),@"size":@(10)};
    [TDHttpTools informationHomeWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            
            for (NSDictionary *dict in dic[@"data"][@"newinformation"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.newestData addObject:model];
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
    [self.view addSubview:self.tableView];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewData];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.customNavi.bottom, kScreenWidth, kScreenHeight-self.customNavi.height-kTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView=[self headerView];
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
        
    }
    return _tableView;
}
-(UIView *)headerView{
    TableHeader_InformationFirst *header=[[TableHeader_InformationFirst alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 378*kBaseHeight)];
    WS(weakSelf);
    [header setFourBtnClickBlock:^(NSInteger index) {
        NSLog(@"tag%d",(int)index);
        switch (index) {
            case 0:
            {
                BusinessHotViewController *businessHotVC=[BusinessHotViewController new];
                [weakSelf.navigationController pushViewController:businessHotVC animated:YES];
            }
                break;
            case 1:
            {
                NewPolicyViewController *newPolicyVC=[NewPolicyViewController new];
                [weakSelf.navigationController pushViewController:newPolicyVC animated:YES];
            }
                break;
            case 2:
            {
                InnovateYTViewController *innovateVC=[InnovateYTViewController new];
                [weakSelf.navigationController pushViewController:innovateVC animated:YES];
            }
                break;
            default:
            {
                FastInformationViewController *fastVC=[FastInformationViewController new];
                [weakSelf.navigationController pushViewController:fastVC animated:YES];
            }
                break;
        }
    }];
    [header.hot_24 setHot_24ClickBlock:^(NSInteger index) {
        NSLog(@"id:%d",(int)index);
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=index;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [header setTopImageClickBlock:^(NSDictionary * _Nonnull dic) {
        NSLog(@"%@",[SJTool logDic:dic]);
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=[dic[@"id"] integerValue];
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    self.header=header;
    return header;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.tuiJianData.count;
    }
    return self.newestData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellIdentifier";
    InformationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[InformationListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.backgroundColor=kBackgroundColor;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        cell.model=self.tuiJianData[indexPath.row];
    }else{
        cell.model=self.newestData[indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
    }
    NSArray *images=@[@"information_recommend",@"information_up-to-date"];
    NSArray *titles=@[@"推荐",@"最新"];
    header.leftIV.image=[UIImage imageNamed:images[section]];
    header.titleLab.text=titles[section];
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        InformationListModel *model=self.tuiJianData[indexPath.row];
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        InformationListModel *model=self.newestData[indexPath.row];
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=model.Id;
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
