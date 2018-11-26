//
//  MyPublishViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MyPublishViewController.h"
#import "Head_BusinessCourse.h"
#import "HuaShanCell_First.h"
#import "HuaShanListModel.h"
#import "CommentCell_Publish.h"
#import "InterestCell_Public.h"
#import "CommentModel_Publish.h"
#import "InterestModel_Public.h"
#import "HuaShanTitleCell_HallFirst.h"
#import "HuaShanDetailViewController.h"
#import "SearchNumbersDetailViewController.h"
#import "CreativityAndProjectDetailViewController.h"
#import "BusinessHotDetailViewController.h"
#import "VideoDetailViewController.h"
#import "NoDataView.h"

@interface MyPublishViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;
@end

@implementation MyPublishViewController
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
            [TDHttpTools myPublishPostListWithParams:param success:^(id response) {
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
            [TDHttpTools myPublishCommentListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        CommentModel_Publish *model=[[CommentModel_Publish alloc]initWithDictionary:dict];
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
            [TDHttpTools myPublishCaredListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        InterestModel_Public *model=[[InterestModel_Public alloc]initWithDictionary:dict];
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
        
            break;
    }
    
}
-(void)getMoreDataWith:(NSInteger)index{
    _page=_page+1;
    
    switch (index) {
        case 0:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools myPublishPostListWithParams:param success:^(id response) {
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
            [TDHttpTools myPublishCommentListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        CommentModel_Publish *model=[[CommentModel_Publish alloc]initWithDictionary:dict];
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
            [TDHttpTools myPublishCaredListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        InterestModel_Public *model=[[InterestModel_Public alloc]initWithDictionary:dict];
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
        
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"我的发表";
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    self.header.selectedIndex=self.index;
    self.header.fixedTitles=@[@"主题",@"评论",@"感兴趣"];
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
            HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=[UIColor whiteColor];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellID=@"cellIdentifier2";
            CommentCell_Publish *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[CommentCell_Publish alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 2:
        {
            NSString *cellID=@"cellIdentifier3";
            InterestCell_Public *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[InterestCell_Public alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
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
            HuaShanListModel *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        case 1:
        {
            CommentModel_Publish *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CommentCell_Publish class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        case 2:
        {
            InterestModel_Public *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[InterestCell_Public class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        default:
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
            
            detailVC.postId=model.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 1:
        {
            CommentModel_Publish *model=self.dataArr[indexPath.row];
            //根据model.module分类跳转不同的详情页
            [self jumpWithId:model.targetId module:model.module];
        }
            break;
        case 2:
        {
            InterestModel_Public *model=self.dataArr[indexPath.row];
            SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
            detailVC.Id=model.findTeamUserId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        
        default:
            break;
    }
}
-(void)jumpWithId:(int)targetId module:(NSString *)module{
    if ([module isEqualToString:@"idea"]) {
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=0;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"project"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=1;
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"information"]){
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        detailVC.Id=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"course"]){
        VideoDetailViewController *detailVC=[VideoDetailViewController new];
        detailVC.courseId=targetId;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([module isEqualToString:@"post"]){
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
