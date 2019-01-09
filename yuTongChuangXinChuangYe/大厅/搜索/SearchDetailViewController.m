//
//  SearchDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "Head_BusinessCourse.h"
#import "InformationListModel.h"
#import "InformationListCell.h"
#import "BusinessHotDetailViewController.h"
#import "DetailViewController.h"
#import "PolicyDetailViewController.h"
#import "PolicyListCell.h"
#import "SearchCreativityListModel.h"
#import "SearchNumbersListModel_Hall.h"
#import "Hall_CreativityListCell.h"
#import "GotoSearchPeopleCell.h"
#import "CreativityAndProjectDetailViewController.h"
#import "SearchNumbersDetailViewController.h"
#import "StarCourseModel_Serve.h"
#import "HotServeSecondCell_ServeFirst.h"
#import "ServerDetailViewController.h"
#import "VideoDetailViewController.h"
#import "StarProjectCell_HallFirst.h"
#import "HuaShanDetailViewController.h"
#import "HuaShanListModel.h"
#import "HuaShanTitleCell_HallFirst.h"

@interface SearchDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataTitle;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString *module;

@end

@implementation SearchDetailViewController
-(NSMutableArray *)dataTitle{
    if (!_dataTitle) {
        _dataTitle=[NSMutableArray array];
    }
    return _dataTitle;
}
-(NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    
    [self initCenterView];
    
    self.header=[[Head_BusinessCourse alloc]init];
    self.header.frame=CGRectMake(0, 0, kScreenWidth, 40);
    self.header.bgColor=kBackgroundColor;
    WS(weakSelf);
    [self.header setTopSegmentChangeSecondBlock:^(NSString *module) {
        
        weakSelf.module=module;
        [weakSelf getNewDataWithModule:module];
    }];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    [self getCategoryData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewDataWithModule:weakSelf.module];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreDataWithModule:weakSelf.module];
        
    }];
}
-(void)initCenterView{
    UIButton *centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.frame=CGRectMake(0, 7, kScreenWidth-50, 30);
    [centerBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    centerBtn.imageView.contentMode=UIViewContentModeCenter;
    [centerBtn setTitle:self.name forState:UIControlStateNormal];
    centerBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [centerBtn setTitleColor:[UIColor colorWithHexString:@"cacaca"] forState:UIControlStateNormal];
    [centerBtn setBackgroundColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [centerBtn addTarget:self action:@selector(gotoSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    centerBtn.layer.cornerRadius=5;
    
    centerBtn.layer.masksToBounds=YES;
    self.navigationItem.titleView=centerBtn;
}
-(void)gotoSearchVC:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getCategoryData{
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"keyword":self.name};
    [TDHttpTools searchDetailCatogeryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataTitle removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            self.dataTitle=dic[@"data"];
            self.header.searchTitleArr=self.dataTitle;
            if (self.dataTitle.count>0) {
                NSDictionary *dict=self.dataTitle.firstObject;
                self.module=dict[@"module"];
                [self getNewDataWithModule:dict[@"module"]];
            }
            
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getNewDataWithModule:(NSString *)module{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    
    if ([module isEqualToString:@"行业热点"]) {
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"keyword":self.name,@"size":@(10),@"page":@(_page),@"categoryId":@(-1)};
        [self.dataArr removeAllObjects];
        [TDHttpTools informationHotListWithParams:param success:^(id response) {
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
    }else if ([module isEqualToString:@"创新宇通"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools innovationListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
    }else if ([module isEqualToString:@"政策"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"industryId":@(-1),@"regionId":@(-1),@"type":@(-1),@"size":@(10),@"page":@(_page),@"user_token":user_token,@"userKey":VENDER_IDENTIFIER,@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools policyListWithParams:param success:^(id response) {
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
    }else if ([module isEqualToString:@"创意"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools searchCreativityListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"records"]) {
                    SearchCreativityListModel *model=[[SearchCreativityListModel alloc]initWithDictionary:dict];
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
        
    }else if ([module isEqualToString:@"项目"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools searchProjectListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"records"]) {
                    SearchCreativityListModel *model=[[SearchCreativityListModel alloc]initWithDictionary:dict];
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
    }else if ([module isEqualToString:@"团队"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools searchNumbersListWithParams:param success:^(id response) {
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
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tableView.mj_header endRefreshing];
        }];
    }else if ([module isEqualToString:@"服务商"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"userKey":VENDER_IDENTIFIER,@"keyword":self.name};
        [self.dataArr removeAllObjects];
        
        [TDHttpTools searchProviderListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            
            NSLog(@"%@",dic);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"]) {
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
        
    }else if ([module isEqualToString:@"创业课程"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"categoryId":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools courseListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
    }else if ([module isEqualToString:@"帖子"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"blockId":@(0),@"themeId":@(-1),@"type":@(-1),@"keyword":self.name};
        [self.dataArr removeAllObjects];
        [TDHttpTools systemHallListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tableView.mj_header endRefreshing];
        }];
    }
}
-(void)getMoreDataWithModule:(NSString *)module{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (user_token==nil) {
        user_token=@"";
    }
    if ([module isEqualToString:@"行业热点"]) {
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"keyword":self.name,@"size":@(10),@"page":@(_page),@"categoryId":@(-1)};
        [TDHttpTools informationHotListWithParams:param success:^(id response) {
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
    }else if ([module isEqualToString:@"创新宇通"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"keyword":self.name};
        [TDHttpTools innovationListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }];
    }else if ([module isEqualToString:@"政策"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"industryId":@(-1),@"regionId":@(-1),@"type":@(-1),@"size":@(10),@"page":@(_page),@"user_token":user_token,@"userKey":VENDER_IDENTIFIER,@"keyword":self.name};
        [TDHttpTools policyListWithParams:param success:^(id response) {
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
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }];
    }else if ([module isEqualToString:@"创意"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [TDHttpTools searchCreativityListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"records"]) {
                    SearchCreativityListModel *model=[[SearchCreativityListModel alloc]initWithDictionary:dict];
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
    }else if ([module isEqualToString:@"项目"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [TDHttpTools searchProjectListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"records"]) {
                    SearchCreativityListModel *model=[[SearchCreativityListModel alloc]initWithDictionary:dict];
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
    }else if ([module isEqualToString:@"团队"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [TDHttpTools searchNumbersListWithParams:param success:^(id response) {
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
    }else if ([module isEqualToString:@"服务商"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"userKey":VENDER_IDENTIFIER,@"keyword":self.name};
        [TDHttpTools searchProviderListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            
            NSLog(@"%@",dic);
            [self.dataArr removeAllObjects];
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"]) {
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
            [self.tableView.mj_footer endRefreshing];
        }];
    }else if ([module isEqualToString:@"创业课程"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"categoryId":@(-1),@"size":@(10),@"page":@(_page),@"keyword":self.name};
        [TDHttpTools courseListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
    }else if ([module isEqualToString:@"帖子"]){
        NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"blockId":@(0),@"themeId":@(-1),@"type":@(-1),@"keyword":self.name};
        [TDHttpTools systemHallListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            
            if ([dic[@"code"] intValue]==200) {
                for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.module isEqualToString:@"行业热点"]||[self.module isEqualToString:@"创新宇通"]) {
        NSString *cellID1=@"cellID1";
        InformationListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell=[[InformationListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=kBackgroundColor;
        }
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }else if ([self.module isEqualToString:@"政策"]){
        NSString *cellID2=@"cellID2";
        PolicyListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell=[[PolicyListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=kBackgroundColor;
        }
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }else if ([self.module isEqualToString:@"创意"]||[self.module isEqualToString:@"项目"]){
        NSString *cellID3=@"cellID3";
        Hall_CreativityListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID3];
        if (!cell) {
            cell=[[Hall_CreativityListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID3];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (self.dataArr.count>0) {
            cell.model=self.dataArr[indexPath.row];
        }
        return cell;
    }else if ([self.module isEqualToString:@"团队"]){
        NSString *cellID4=@"cellID4";
        GotoSearchPeopleCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID4];
        if (!cell) {
            cell=[[GotoSearchPeopleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID4];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }else if ([self.module isEqualToString:@"服务商"]){
        NSString *cellID5=@"cellID5";
        HotServeSecondCell_ServeFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID5];
        if (!cell) {
            cell=[[HotServeSecondCell_ServeFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID5];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }else if ([self.module isEqualToString:@"创业课程"]){
        static NSString *cellID6=@"cellID6";
        StarProjectCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID6];
        if (!cell) {
            cell=[[StarProjectCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID6];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.model_serve=self.dataArr[indexPath.row];
        return cell;
    }else if ([self.module isEqualToString:@"帖子"]){
        static NSString *cellID7=@"cellID7";
        HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID7];
        if (!cell) {
            cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID7];
            cell.backgroundColor=kBackgroundColor;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        HuaShanListModel *model=self.dataArr[indexPath.row];
        cell.model=model;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.module isEqualToString:@"行业热点"]||[self.module isEqualToString:@"创新宇通"]||[self.module isEqualToString:@"创意"]||[self.module isEqualToString:@"项目"]) {
        return 115;//100;
    }else if ([self.module isEqualToString:@"政策"]||[self.module isEqualToString:@"创业课程"]){
        return 100;//75;
    }else if ([self.module isEqualToString:@"团队"]){
        return 75;
    }else if ([self.module isEqualToString:@"服务商"]){
        return 85;
    }else if ([self.module isEqualToString:@"帖子"]){
        HuaShanListModel *model=self.dataArr[indexPath.row];
        CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
        return height;
    }
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.module isEqualToString:@"行业热点"]) {
        BusinessHotDetailViewController *detailVC=[BusinessHotDetailViewController new];
        InformationListModel *model=self.dataArr[indexPath.row];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"创新宇通"]){
        DetailViewController *detailVC=[DetailViewController new];
        InformationListModel *model=self.dataArr[indexPath.row];
        detailVC.innovationId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"政策"]){
        PolicyDetailViewController *detailVC=[PolicyDetailViewController new];
        InformationListModel *model=self.dataArr[indexPath.row];
        detailVC.policyId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"创意"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=0;
        SearchCreativityListModel *model=self.dataArr[indexPath.row];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"项目"]){
        CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
        detailVC.index=1;
        SearchCreativityListModel *model=self.dataArr[indexPath.row];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"团队"]){
        SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
        SearchNumbersListModel_Hall *model=self.dataArr[indexPath.row];
        detailVC.Id=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"服务商"]){
        ServerDetailViewController *detailVC=[ServerDetailViewController new];
        StarCourseModel_Serve *model=self.dataArr[indexPath.row];
        detailVC.providerId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"创业课程"]){
        VideoDetailViewController *detailVC=[VideoDetailViewController new];
        StarCourseModel_Serve *model=self.dataArr[indexPath.row];
        detailVC.courseId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([self.module isEqualToString:@"帖子"]){
        HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
        HuaShanListModel *model=self.dataArr[indexPath.row];
        detailVC.postId=model.Id;
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
