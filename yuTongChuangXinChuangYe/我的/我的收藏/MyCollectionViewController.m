//
//  MyCollectionViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "Head_BusinessCourse.h"
#import "HuaShanCell_First.h"
#import "HuaShanListModel.h"
#import "StarProjectCell_HallFirst.h"
#import "PolicyListCell.h"
#import "HotServeSecondCell_ServeFirst.h"
#import "HuaShanTitleCell_HallFirst.h"
#import "HuaShanDetailViewController.h"
#import "StarCourseModel_Serve.h"
#import "VideoDetailViewController.h"
#import "InformationListModel.h"
#import "PolicyDetailViewController.h"
#import "ServerDetailViewController.h"
#import "InformationListCell.h"
#import "BusinessHotDetailViewController.h"
#import "NoDataView.h"

@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;
@end

@implementation MyCollectionViewController
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
    
    switch (index) {
        case 0:
        {
            
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionPostListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dict];
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
            
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"categoryId":@(-1)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionCourseListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
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
        case 2:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionPolicyListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
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
        case 3:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionProviderListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
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
        default:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionInformationListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
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
    
}
-(void)getMoreDataWith:(NSInteger)index{
    _page=_page+1;
    
    switch (index) {
        case 0:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools myCollectionPostListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
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
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                });
            }];
        }
            break;
        case 1:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page),@"categoryId":@(-1)};
            [TDHttpTools myCollectionCourseListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
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
        case 2:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools myCollectionPolicyListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
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
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                });
            }];
        }
            break;
        case 3:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionProviderListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        StarCourseModel_Serve *model=[[StarCourseModel_Serve alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
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
            break;
        default:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myCollectionInformationListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        InformationListModel *model=[[InformationListModel alloc]initWithDictionary:dict];
                        [self.dataArr addObject:model];
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
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"我的收藏";
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    self.header.selectedIndex=self.index;
    self.header.fixedTitles=@[@"主题",@"课程",@"政策",@"服务商",@"热点"];
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
            static NSString *cellId1=@"cellIdentifier1";
            HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId1];
            if (!cell) {
                cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (self.dataArr.count>0) {
                HuaShanListModel *model=self.dataArr[indexPath.row];
                cell.model=model;
            }
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellId2=@"cellIdentifier2";
            StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellId2];
            if (!cell) {
                cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model_serve=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 2:
        {
            NSString *cellID2=@"cellID2";
            PolicyListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell) {
                cell=[[PolicyListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.backgroundColor=kBackgroundColor;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 3:
        {
            NSString *cellID4=@"cellIdentifier4";
            HotServeSecondCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID4];
            if (!cell) {
                cell=[[HotServeSecondCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID4];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        default:
        {
            NSString *cellID5=@"cellIdentifier5";
            InformationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID5];
            if (!cell) {
                cell=[[InformationListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID5];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (self.index) {
        case 0:
        {
            HuaShanListModel *model=self.dataArr[indexPath.row];
            CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        case 1:
        {
            height=100;
            return height;
        }
            break;
        case 2:
        {
            height=75;
            return height;
        }
            break;
        case 3:
        {
            height=85;
            return height;
        }
            break;
        default:
            return 100;
            break;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.index) {
        case 0:
        {
            HuaShanListModel *model=self.dataArr[indexPath.row];
            HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
            
            detailVC.postId=model.postId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 1:
        {
            StarCourseModel_Serve *model=self.dataArr[indexPath.row];
            VideoDetailViewController *detailVC=[VideoDetailViewController new];
            detailVC.courseId=model.courseId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 2:
        {
            InformationListModel *model=self.dataArr[indexPath.row];
            PolicyDetailViewController *detailVC=[PolicyDetailViewController new];
            detailVC.policyId=model.policyId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 3:
        {
            StarCourseModel_Serve *model=self.dataArr[indexPath.row];
            ServerDetailViewController *detailVC=[ServerDetailViewController new];
            detailVC.providerId=model.providerId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        default:
        {
            InformationListModel *model=self.dataArr[indexPath.row];
            BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
            detailVC.Id=model.informationId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
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
