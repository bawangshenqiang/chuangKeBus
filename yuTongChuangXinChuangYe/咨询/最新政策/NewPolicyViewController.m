//
//  NewPolicyViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "NewPolicyViewController.h"
#import "Head_BusinessCourse.h"
#import "FilterView.h"
#import "PolicyTopView.h"
#import "PolicyListCell.h"
#import "PolicyDetailViewController.h"
#import "InformationListModel.h"

@interface NewPolicyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableArray *dataTitle_industry;
@property(nonatomic,strong)NSMutableArray *dataTitle_region;
@property(nonatomic,strong)FilterView *filterView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PolicyTopView *topView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)NSInteger industryId;//行业
@property(nonatomic,assign)NSInteger regionId;//区域
@property(nonatomic,assign)NSInteger type;//区域、行业：1;解读：2
@property(nonatomic,assign)NSInteger topIndex;
@end

@implementation NewPolicyViewController

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(NSMutableArray *)dataTitle_industry{
    if (!_dataTitle_industry) {
        _dataTitle_industry=[NSMutableArray array];
    }
    return _dataTitle_industry;
}
-(NSMutableArray *)dataTitle_region{
    if (!_dataTitle_region) {
        _dataTitle_region=[NSMutableArray array];
    }
    return _dataTitle_region;
}
-(void)getData{
//    self.dataTitle=[NSMutableArray arrayWithObjects:@{@"name":@"全国"},@{@"name":@"宇通"},@{@"name":@"北京"},@{@"name":@"上海"},@{@"name":@"广东"},@{@"name":@"山东"}, nil];
//    self.header.titleArr=self.dataTitle;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"userKey":VENDER_IDENTIFIER};
    [TDHttpTools policyCatogeryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataTitle_region removeAllObjects];
        [self.dataTitle_industry removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            self.dataTitle_region=dic[@"data"][@"regions"];
            self.dataTitle_industry=dic[@"data"][@"industrys"];
            self.header.titleArr=self.dataTitle_region;
            if (self.dataTitle_region.count>0 && self.dataTitle_industry.count>0) {
                NSDictionary *dict1=self.dataTitle_region.firstObject;
                NSDictionary *dict2=self.dataTitle_industry.firstObject;
                self.regionId=[dict1[@"id"] integerValue];
                self.industryId=[dict2[@"id"] integerValue];
                [self getNewDataWithIndustryId:-1 regionId:self.regionId type:1];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getNewDataWithIndustryId:(NSInteger)industryId regionId:(NSInteger)regionId type:(NSInteger)type{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"industryId":@(industryId),@"regionId":@(regionId),@"type":@(type),@"size":@(10),@"page":@(_page),@"user_token":user_token,@"userKey":VENDER_IDENTIFIER};
    [TDHttpTools policyListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataList removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.dataList addObject:model];
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
-(void)getMoreDataWithIndustryId:(NSInteger)industryId regionId:(NSInteger)regionId type:(NSInteger)type{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"industryId":@(industryId),@"regionId":@(regionId),@"type":@(type),@"size":@(10),@"page":@(_page),@"user_token":user_token,@"userKey":VENDER_IDENTIFIER};
    [TDHttpTools policyListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"records"]) {
                InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                [self.dataList addObject:model];
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
    self.title=@"政策";
    self.view.backgroundColor=kBackgroundColor;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"hotspot_screen"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    //
    self.topView=[[PolicyTopView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 40) titles:@[@"区域",@"行业",@"解析"]];
    [self.topView setImage:@[@"policy_area",@"policy_industry",@"policy_interpretation"] andSelectedImage:@[@"policy_area_nor",@"policy_industry_nor",@"policy_interpretation_nor"]];
    [self.view addSubview:self.topView];
    WS(weakSelf);
    [self.topView setButtonClickBlock:^(NSInteger index) {
        //NSLog(@"tag=%d",(int)index);
        weakSelf.topIndex=index-1000;
        [weakSelf initHeaderWith:index];
    }];
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, self.topView.bottom, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    [self.header setTopSegmentChangeBlock:^(int index) {
        //NSLog(@"index=%d",index);
        if (weakSelf.topIndex==0) {
            NSDictionary *dic=weakSelf.dataTitle_region[index];
            weakSelf.regionId=[dic[@"id"] integerValue];
            [weakSelf getNewDataWithIndustryId:-1 regionId:weakSelf.regionId type:1];
        }else if (weakSelf.topIndex==1){
            NSDictionary *dic=weakSelf.dataTitle_industry[index];
            weakSelf.industryId=[dic[@"id"] integerValue];
            [weakSelf getNewDataWithIndustryId:weakSelf.industryId regionId:-1 type:1];
        }
    }];
    [self.view addSubview:self.header];
    //
    [self.view addSubview:self.tableView];
    
    [self getData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.topIndex==0) {
            [weakSelf getNewDataWithIndustryId:-1 regionId:weakSelf.regionId type:1];
        }else if (weakSelf.topIndex==1){
            [weakSelf getNewDataWithIndustryId:weakSelf.industryId regionId:-1 type:1];
        }else{
            [weakSelf getNewDataWithIndustryId:-1 regionId:-1 type:2];
        }
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        if (weakSelf.topIndex==0) {
            [weakSelf getMoreDataWithIndustryId:-1 regionId:weakSelf.regionId type:1];
        }else if (weakSelf.topIndex==1){
            [weakSelf getMoreDataWithIndustryId:weakSelf.industryId regionId:-1 type:1];
        }else{
            [weakSelf getMoreDataWithIndustryId:-1 regionId:-1 type:2];
        }
        
    }];
}
-(void)initHeaderWith:(NSInteger)index{
    switch (index) {
        case 1000:
        {
            self.header.hidden=NO;
            self.header.titleArr=self.dataTitle_region;
            self.header.contentOffset=CGPointMake(0, 0);
            self.tableView.frame=CGRectMake(0, self.header.bottom, kScreenWidth, kTableViewHeight-90);
            NSDictionary *dict=self.dataTitle_region.firstObject;
            self.regionId=[dict[@"id"] integerValue];
            [self getNewDataWithIndustryId:-1 regionId:self.regionId type:1];
        }
            break;
        case 1001:
        {
            self.header.hidden=NO;
            self.header.titleArr=self.dataTitle_industry;
            self.header.contentOffset=CGPointMake(0, 0);
            self.tableView.frame=CGRectMake(0, self.header.bottom, kScreenWidth, kTableViewHeight-90);
            NSDictionary *dict=self.dataTitle_industry.firstObject;
            self.industryId=[dict[@"id"] integerValue];
            [self getNewDataWithIndustryId:self.industryId regionId:-1 type:1];
        }
            break;
        case 1002:
            self.header.hidden=YES;
            self.header.titleArr=[NSMutableArray array];
            self.tableView.frame=CGRectMake(0, self.topView.bottom+5, kScreenWidth, kTableViewHeight-50-5);
            [self getNewDataWithIndustryId:-1 regionId:-1 type:2];
            break;
    }
    
    
}
-(void)rightBarButtonClick{
    if (self.topIndex==0) {
        self.filterView=[[FilterView alloc]initWithArr:self.dataTitle_region];
        WS(weakSelf);
        [self.filterView setCommitBlock:^(NSMutableArray * _Nonnull dataArray) {
            [weakSelf saveCategoryWith:dataArray moduleStr:@"region"];
            weakSelf.dataTitle_region=dataArray;
            weakSelf.header.titleArr=dataArray;
            weakSelf.header.contentOffset=CGPointMake(0, 0);
            NSDictionary *dict=weakSelf.dataTitle_region.firstObject;
            weakSelf.regionId=[dict[@"id"] integerValue];
            [weakSelf getNewDataWithIndustryId:-1 regionId:weakSelf.regionId type:1];
        }];
        
    }else if (self.topIndex==1){
        self.filterView=[[FilterView alloc]initWithArr:self.dataTitle_industry];
        WS(weakSelf);
        [self.filterView setCommitBlock:^(NSMutableArray * _Nonnull dataArray) {
            [weakSelf saveCategoryWith:dataArray moduleStr:@"policyind"];
            weakSelf.dataTitle_industry=dataArray;
            weakSelf.header.titleArr=dataArray;
            weakSelf.header.contentOffset=CGPointMake(0, 0);
            NSDictionary *dict=weakSelf.dataTitle_industry.firstObject;
            weakSelf.industryId=[dict[@"id"] integerValue];
            [weakSelf getNewDataWithIndustryId:weakSelf.industryId regionId:-1 type:1];
        }];
        
    }
}
//保存用户排序后的分类信息
-(void)saveCategoryWith:(NSMutableArray *)arr moduleStr:(NSString *)string{
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    NSString *start=@"";
    NSString *end=@"";
    for (int i=0; i<arr.count; i++) {
        NSDictionary *dic=arr[i];
        NSString *str=[NSString stringWithFormat:@"%@",dic[@"id"]];
        if (i<arr.count-1) {
            start=[str stringByAppendingString:@","];
        }else{
            start=str;
        }
        end=[end stringByAppendingString:start];
    }
    //NSLog(@"%@",end);
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":string,@"userKey":VENDER_IDENTIFIER,@"category":end};
    //NSLog(@"%@",[SJTool logDic:param]);
    [TDHttpTools saveUserCatogeryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom, kScreenWidth, kTableViewHeight-90) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID2=@"cellID2";
    PolicyListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
    if (!cell) {
        cell=[[PolicyListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=kBackgroundColor;
    }
    cell.model=self.dataList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PolicyDetailViewController *detailVC=[PolicyDetailViewController new];
    InformationListModel *model=self.dataList[indexPath.row];
    detailVC.policyId=model.Id;
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
