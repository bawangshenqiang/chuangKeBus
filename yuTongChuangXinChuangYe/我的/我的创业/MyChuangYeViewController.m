//
//  MyChuangYeViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MyChuangYeViewController.h"
#import "Head_BusinessCourse.h"
#import "ChuangYiCell_ChuangYe.h"
#import "ChuangYiModel_ChuangYe.h"
#import "ProjectCell_ChuangYe.h"
#import "ProjectModel_ChuangYe.h"
#import "TeamCell_ChuangYe.h"
#import "ResourceCell_ChuangYe.h"
#import "BusinessResourceViewController.h"
#import "SubmitCreativityViewController.h"
#import "SubmitProjectViewController.h"
#import "SearchNumbersViewController.h"
#import "CreativityAndProjectDetailViewController.h"
#import "SearchNumbersListModel_Hall.h"
#import "SearchNumbersDetailViewController.h"
#import "LoginViewController.h"
#import "ResourceModel_ChuangYe.h"
#import "ServerDetailViewController.h"
#import "NoDataView.h"
#import "ChuangYiCell_ChuangYe_Second.h"
#import "ChuangYiAuditViewController.h"
#import "ProjectCell_ChuangYe_Second.h"
#import "ProjectFooter.h"
#import "ProjectAuditViewController.h"
#import "ResourceModel_ChuangYe_second.h"

@interface MyChuangYeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *bottomBtn;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NoDataView *noDataView;

@end

@implementation MyChuangYeViewController

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
            [TDHttpTools myCreativityListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ChuangYiModel_ChuangYe *model=[[ChuangYiModel_ChuangYe alloc]initWithDictionary:dict];
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
                    self.bottomBtn.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                    self.bottomBtn.hidden=YES;
                }
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [self.tableView.mj_header endRefreshing];
            }];
        }
            break;
        case 1:
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myProjectListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ProjectModel_ChuangYe *model=[[ProjectModel_ChuangYe alloc]initWithDictionary:dict];
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
                    self.bottomBtn.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                    self.bottomBtn.hidden=YES;
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
            [TDHttpTools myTeamListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        SearchNumbersListModel_Hall *model=[[SearchNumbersListModel_Hall alloc]initWithDictionary:dict];
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
                    self.bottomBtn.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                    self.bottomBtn.hidden=YES;
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
            [TDHttpTools myProviderListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ResourceModel_ChuangYe_second *model=[[ResourceModel_ChuangYe_second alloc]initWithDictionary:dict];
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
                    self.bottomBtn.hidden=NO;
                }else{
                    self.noDataView.hidden=YES;
                    self.bottomBtn.hidden=YES;
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
            [TDHttpTools myCreativityListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ChuangYiModel_ChuangYe *model=[[ChuangYiModel_ChuangYe alloc]initWithDictionary:dict];
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
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [TDHttpTools myProjectListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ProjectModel_ChuangYe *model=[[ProjectModel_ChuangYe alloc]initWithDictionary:dict];
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
            [TDHttpTools myTeamListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        SearchNumbersListModel_Hall *model=[[SearchNumbersListModel_Hall alloc]initWithDictionary:dict];
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
        {
            NSDictionary *param=@{@"user_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"],@"size":@(10),@"page":@(_page)};
            [self.dataArr removeAllObjects];
            [TDHttpTools myProviderListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        ResourceModel_ChuangYe_second *model=[[ResourceModel_ChuangYe_second alloc]initWithDictionary:dict];
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
    self.title=@"我的创业";
    //
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    //self.header.bgColor=kBackgroundColor;
    self.header.selectedIndex=self.index;
    self.header.fixedTitles=@[@"创意",@"项目",@"团队",@"资源"];
    WS(weakSelf);
    [self.header setTopSegmentChangeBlock:^(int index) {
        NSLog(@"index=%d",index);
        
        [weakSelf topHeadSelectClick:index];
    }];
    [self.view addSubview:self.header];
    
    [self.view addSubview:self.tableView];
    
    //
    self.bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.frame=CGRectMake(50, self.tableView.bottom-60, kScreenWidth-100, 40);
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomBtn.backgroundColor=kThemeColor;
    self.bottomBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    self.bottomBtn.layer.cornerRadius=5;
    self.bottomBtn.layer.shadowColor=kThemeColor.CGColor;
    self.bottomBtn.layer.shadowRadius=4;
    self.bottomBtn.layer.shadowOpacity=0.5;
    self.bottomBtn.layer.shadowOffset=CGSizeMake(0, 2);
    [self.bottomBtn addTarget:self action:@selector(bottomClick) forControlEvents:UIControlEventTouchUpInside];
    self.bottomBtn.hidden=YES;
    [self.view addSubview:self.bottomBtn];
    switch (self.index) {
        case 0:
            [self.bottomBtn setTitle:@"提交创意" forState:UIControlStateNormal];
            break;
        case 1:
            [self.bottomBtn setTitle:@"提交项目" forState:UIControlStateNormal];
            break;
        case 2:
            [self.bottomBtn setTitle:@"寻找成员" forState:UIControlStateNormal];
            break;
        default:
            [self.bottomBtn setTitle:@"提交服务需求" forState:UIControlStateNormal];
            break;
    }
    
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
    switch (index) {
        case 0:
            [self.bottomBtn setTitle:@"提交创意" forState:UIControlStateNormal];
            break;
        case 1:
            [self.bottomBtn setTitle:@"提交项目" forState:UIControlStateNormal];
            break;
        case 2:
            [self.bottomBtn setTitle:@"寻找成员" forState:UIControlStateNormal];
            break;
        default:
            [self.bottomBtn setTitle:@"提交服务需求" forState:UIControlStateNormal];
            break;
    }
    [self getNewDataWith:index];
}
-(void)bottomClick{
    if ([Account sharedAccount]==nil) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNavi animated:YES completion:nil];
    }else{
        switch (self.index) {
            case 0:
            {
                SubmitCreativityViewController *creativityVC=[SubmitCreativityViewController new];
                [self.navigationController pushViewController:creativityVC animated:YES];
            }
                break;
            case 1:
            {
                SubmitProjectViewController *projectVC=[SubmitProjectViewController new];
                [self.navigationController pushViewController:projectVC animated:YES];
            }
                break;
            case 2:
            {
                SearchNumbersViewController *numbersVC=[SearchNumbersViewController new];
                [self.navigationController pushViewController:numbersVC animated:YES];
            }
                break;
            default:
            {
                BusinessResourceViewController *businessVC=[BusinessResourceViewController new];
                [self.navigationController pushViewController:businessVC animated:YES];
            }
                break;
        }
    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom, kScreenWidth, kTableViewHeight-40) style:UITableViewStyleGrouped];
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
            NSString *cellID1=@"cellID1";
            ChuangYiCell_ChuangYe_Second *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
            if (!cell) {
                cell=[[ChuangYiCell_ChuangYe_Second alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            ChuangYiModel_ChuangYe *model=self.dataArr[indexPath.row];
            cell.model=model;
            WS(weakSelf);
            [cell setCheckIdeaBlock:^(ChuangYiModel_ChuangYe * _Nonnull model) {
                //跳转到审核意见页面
                if (model.statusId==0 || model.statusId==3){
                    [SJTool showAlertWithText:@"创意审核中请耐心等待"];
                }else{
                    ChuangYiAuditViewController *auditVC=[ChuangYiAuditViewController new];
                    auditVC.model=model;
                    auditVC.title=model.title;
                    [weakSelf.navigationController pushViewController:auditVC animated:YES];
                }
                
            }];
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellID2=@"cellID2";
            ProjectCell_ChuangYe_Second *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell) {
                cell=[[ProjectCell_ChuangYe_Second alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
            cell.model=model;
            WS(weakSelf);
            [cell setCheckIdeaBlock:^(ProjectModel_ChuangYe * _Nonnull model) {
                //跳转到审核意见页面
                ProjectCheckModel_ChuangYe *littleModel=model.checkModels.firstObject;
                if (littleModel.state==0) {
                    [SJTool showAlertWithText:@"项目审核中请耐心等待"];
                }else{
                    ProjectAuditViewController *auditVC=[ProjectAuditViewController new];
                    auditVC.model=model;
                    auditVC.title=@"审核记录";//model.title;
                    [weakSelf.navigationController pushViewController:auditVC animated:YES];
                }
            }];
            return cell;
        }
            break;
        case 2:
        {
            NSString *cellID3=@"cellID3";
            TeamCell_ChuangYe *cell=[tableView dequeueReusableCellWithIdentifier:cellID3];
            if (!cell) {
                cell=[[TeamCell_ChuangYe alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID3];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 3:
        {
            NSString *cellID4=@"cellID4";
            ResourceCell_ChuangYe *cell=[tableView dequeueReusableCellWithIdentifier:cellID4];
            if (!cell) {
                cell=[[ResourceCell_ChuangYe alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID4];
                cell.backgroundColor=kBackgroundColor;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.dataArr[indexPath.row];
            WS(weakSelf);
            [cell setBtnClickBlock:^(int iD) {
                ServerDetailViewController *detailVC=[ServerDetailViewController new];
                detailVC.providerId=iD;
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            }];
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
            ChuangYiModel_ChuangYe *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ChuangYiCell_ChuangYe_Second class] contentViewWidth:kScreenWidth];
            return height;
        }
            break;
        case 1:
        {
            ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectCell_ChuangYe_Second class] contentViewWidth:kScreenWidth-20];
            return height;
        }
            break;
        case 2:
        {
            height=130;
            return height;
        }
            break;
        case 3:
        {
            ResourceModel_ChuangYe_second *model=self.dataArr[indexPath.row];
            height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ResourceCell_ChuangYe class] contentViewWidth:kScreenWidth];
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
                ChuangYiModel_ChuangYe *model=self.dataArr[indexPath.row];
                CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
                detailVC.index=self.index;
                
                detailVC.Id=model.Id;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            break;
        case 1:
        {
            ProjectModel_ChuangYe *model=self.dataArr[indexPath.row];
            CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
            detailVC.index=self.index;
            
            detailVC.Id=model.projectId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 2:
        {
            SearchNumbersListModel_Hall *model=self.dataArr[indexPath.row];
            SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
            detailVC.Id=model.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        case 3:
        {
//            ResourceModel_ChuangYe_second *model=self.dataArr[indexPath.row];
//            ServerDetailViewController *detailVC=[ServerDetailViewController new];
//            detailVC.providerId=model.providerId;
//            [self.navigationController pushViewController:detailVC animated:YES];
        }
            break;
        default:
            break;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer=[[UIView alloc]init];
    if (self.index==1 && self.dataArr.count>0) {
        ProjectFooter *foot=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        if (!foot) {
            foot=[[ProjectFooter alloc]initWithReuseIdentifier:@"footer"];
        }
        footer=foot;
        
    }
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.index==1 && self.dataArr.count>0) {
        return 125;
    }
    return 0.01;
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
