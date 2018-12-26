//
//  BusinessHotViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "BusinessHotViewController.h"
#import "Head_BusinessCourse.h"
#import "FilterView.h"
#import "CycleScrollImageCell.h"
#import "InformationListCell.h"
#import "BusinessHotDetailViewController.h"
#import "InformationListModel.h"


@interface BusinessHotViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableArray *dataTitle;
@property(nonatomic,strong)FilterView *filterView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)NSInteger categoryId;
@end

@implementation BusinessHotViewController
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList=[NSMutableArray array];
    }
    return _dataList;
}
-(NSMutableArray *)dataTitle{
    if (!_dataTitle) {
        _dataTitle=[NSMutableArray array];
    }
    return _dataTitle;
}
-(void)getCategoryData{
//    self.dataTitle=[NSMutableArray arrayWithObjects:@{@"name":@"推荐"},@{@"name":@"智能硬件"},@{@"name":@"医疗健康"},@{@"name":@"内容产业"},@{@"name":@"企业服务"}, nil];
//    self.header.titleArr=self.dataTitle;
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"userKey":VENDER_IDENTIFIER};
    [TDHttpTools informationHotCatogeryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataTitle removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            self.dataTitle=dic[@"data"];
            self.header.titleArr=self.dataTitle;
            if (self.dataTitle.count>0) {
                NSDictionary *dict=self.dataTitle.firstObject;
                self.categoryId=[dict[@"id"] integerValue];
                //NSLog(@"categoryId=%d",(int)self.categoryId);
                [self getNewDataWithCategoryId:self.categoryId];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getNewDataWithCategoryId:(NSInteger)categoryId{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"categoryId":@(categoryId),@"size":@(10),@"page":@(_page)};
    [TDHttpTools informationHotListWithParams:param success:^(id response) {
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
-(void)getMoreDataWithCategoryId:(NSInteger)categoryId{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"categoryId":@(categoryId),@"size":@(10),@"page":@(_page)};
    [TDHttpTools informationHotListWithParams:param success:^(id response) {
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        });
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
    self.title=@"行业热点";
    self.view.backgroundColor=kBackgroundColor;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"hotspot_screen"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    WS(weakSelf);
    [self.header setTopSegmentChangeBlock:^(int index) {
        
        NSDictionary *dic=weakSelf.dataTitle[index];
        weakSelf.categoryId=[dic[@"id"] integerValue];
        [weakSelf getNewDataWithCategoryId:weakSelf.categoryId];
    }];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    [self getCategoryData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewDataWithCategoryId:weakSelf.categoryId];
        
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreDataWithCategoryId:weakSelf.categoryId];
        
    }];
}

-(void)rightBarButtonClick{
    self.filterView=[[FilterView alloc]initWithArr:self.dataTitle];
    WS(weakSelf);
    [self.filterView setCommitBlock:^(NSMutableArray * _Nonnull dataArray) {
        [weakSelf saveCategoryWith:dataArray moduleStr:@"industry"];
        weakSelf.dataTitle=dataArray;
        weakSelf.header.titleArr=dataArray;
        weakSelf.header.contentOffset=CGPointMake(0, 0);
        NSDictionary *dict=weakSelf.dataTitle.firstObject;
        weakSelf.categoryId=[dict[@"id"] integerValue];
        //NSLog(@"categoryId=%d",(int)weakSelf.categoryId);
        [weakSelf getNewDataWithCategoryId:weakSelf.categoryId];
    }];
    
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom+10, kScreenWidth, kTableViewHeight-40-10) style:UITableViewStylePlain];
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
//    if (indexPath.row==0) {
//        NSString *cellID1=@"cellID1";
//        CycleScrollImageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
//        if (!cell) {
//            cell=[[CycleScrollImageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//            cell.backgroundColor=kBackgroundColor;
//        }
//        cell.cycleScrollImage.delegate=self;
//         cell.cycleImageUrls=@[@"hall_diagram",@"hall_diagram",@"hall_diagram",@"hall_diagram"];
//        return cell;
//    }else{
//
//    }
    NSString *cellID2=@"cellID2";
    InformationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
    if (!cell) {
        cell=[[InformationListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=kBackgroundColor;
    }
    cell.model=self.dataList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
    InformationListModel *model=self.dataList[indexPath.row];
    detailVC.Id=model.Id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 点击轮播图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld,点我干嘛？",index);
    
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
