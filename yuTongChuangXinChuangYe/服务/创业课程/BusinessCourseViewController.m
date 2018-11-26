//
//  BusinessCourseViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "BusinessCourseViewController.h"
#import "Head_BusinessCourse.h"
#import "StarProjectCell_HallFirst.h"
#import "OnlyOneImageCell.h"
#import "FilterView.h"
#import "VideoDetailViewController.h"
#import "HomePageImgModel.h"
#import "StarCourseModel_Serve.h"

@interface BusinessCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableArray *dataTitle;
@property(nonatomic,strong)FilterView *filterView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)NSInteger categoryId;
@property(nonatomic,strong)NSDictionary *imageDic;

@end

@implementation BusinessCourseViewController
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
    [TDHttpTools courseCatogeryWithParams:param success:^(id response) {
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
    [TDHttpTools courseListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataList removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            
            //self.imageDic=dic[@"data"][@"carousels"][0];
            for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
                StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
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
    [TDHttpTools courseListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
                StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
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
    self.title=@"创业课程";
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
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreDataWithCategoryId:weakSelf.categoryId];
        
    }];
}
-(void)rightBarButtonClick{
    self.filterView=[[FilterView alloc]initWithArr:self.dataTitle];
    WS(weakSelf);
    [self.filterView setCommitBlock:^(NSMutableArray * _Nonnull dataArray) {
        [weakSelf saveCategoryWith:dataArray moduleStr:@"course"];
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom+5, kScreenWidth, kTableViewHeight-40-5) style:UITableViewStylePlain];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        static NSString *cellId1=@"cellIdentifier1";
//        OnlyOneImageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId1];
//        if (!cell) {
//            cell=[[OnlyOneImageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1];
//            cell.backgroundColor=kBackgroundColor;
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        }
//        [cell.oneIV sd_setImageWithURL:[NSURL URLWithString:self.imageDic[@"cover"]] placeholderImage:[UIImage imageNamed:@"listing"]];
//        return cell;
//    }else{
//
//    }
    static NSString *cellId2=@"cellIdentifier2";
    StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
    if (!cell) {
        cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
        cell.backgroundColor=kBackgroundColor;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (self.dataList.count>0) {
        cell.model_serve=self.dataList[indexPath.row];//indexPath.row-1
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        return 130;
//    }
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoDetailViewController *detailVC=[VideoDetailViewController new];
//    if (indexPath.row>0) {
//        StarCourseModel_Serve *model=self.dataList[indexPath.row-1];
//        detailVC.courseId=model.Id;
//    }else{
//        detailVC.courseId=[self.imageDic[@"id"] intValue];
//    }
    StarCourseModel_Serve *model=self.dataList[indexPath.row];
    detailVC.courseId=model.Id;
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
