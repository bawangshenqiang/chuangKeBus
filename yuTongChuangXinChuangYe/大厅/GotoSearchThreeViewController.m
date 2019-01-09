//
//  GotoSearchThreeViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "GotoSearchThreeViewController.h"
#import "StarProjectCell_HallFirst.h"
#import "GotoSearchPeopleCell.h"
#import "SubmitCreativityViewController.h"
#import "SubmitProjectViewController.h"
#import "SearchNumbersViewController.h"
#import "CreativityAndProjectDetailViewController.h"
#import "SearchNumbersDetailViewController.h"
#import "SearchCreativityListModel.h"
#import "Hall_CreativityListCell.h"
#import "SearchNumbersListModel_Hall.h"
#import "LoginViewController.h"
#import "TipsListModel.h"
#import "TipsListCell.h"
#import "TipsDetailViewController.h"
#import "Head_BusinessCourse.h"

@interface GotoSearchThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)UISegmentedControl *topSegment;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)int page;

@property(nonatomic,strong)Head_BusinessCourse *header;
@property(nonatomic,strong)NSMutableArray *dataTitle;
@property(nonatomic,assign)NSInteger categoryId;
@end

@implementation GotoSearchThreeViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)dataTitle{
    if (!_dataTitle) {
        _dataTitle=[NSMutableArray array];
    }
    return _dataTitle;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)getCategoryData{
    
    NSDictionary *param=@{@"module":@"project"};
    
    [TDHttpTools getCatogaryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataTitle removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            NSArray *sourceArr=dic[@"data"];
            NSMutableArray *arr=[NSMutableArray arrayWithArray:sourceArr];
            [arr insertObject:@{@"name":@"小贴士",@"id":@(-2)} atIndex:0];
            [arr insertObject:@{@"name":@"全部",@"id":@(-1)} atIndex:0];
            self.dataTitle=arr;
            self.header.titleArr=self.dataTitle;
            if (self.dataTitle.count>0) {
                NSDictionary *dict=self.dataTitle.firstObject;
                self.categoryId=[dict[@"id"] integerValue];
                NSLog(@"categoryId=%d",(int)self.categoryId);
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
    if (self.index==0) {
        [TDHttpTools searchCreativityListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            [self.dataArr removeAllObjects];
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
    }else if (self.index==1){
        [TDHttpTools searchProjectListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            [self.dataArr removeAllObjects];
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
    }else{
        [TDHttpTools searchNumbersListWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            [self.dataArr removeAllObjects];
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
    }
    
}
-(void)getMoreDataWithCategoryId:(NSInteger)categoryId{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"categoryId":@(categoryId),@"size":@(10),@"page":@(_page)};
    if (self.index==0) {
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
    }else if (self.index==1){
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
    }else{
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
    }
}
/**
-(void)getNewDataNewOrHot:(int)newOrHot{
    _page=1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    
    
    if (self.index==0) {
        
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"idea",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
            [TDHttpTools searchCreativityListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
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
        }
        
    }else if (self.index==1){
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"project",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
            [TDHttpTools searchProjectListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
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
        }
        
    }else{
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"team",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
            [TDHttpTools searchNumbersListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                [self.dataArr removeAllObjects];
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
        }
        
    }
}
-(void)getMoreDataNewOrHot:(int)newOrHot{
    _page=_page+1;
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    
    
    
    if (self.index==0) {
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"idea",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
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
        }
        
    }else if (self.index==1){
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"project",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
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
        }
        
    }else{
        if (newOrHot==3) {
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"module":@"team",@"size":@(100),@"page":@(_page)};
            [TDHttpTools tipsListWithParams:param success:^(id response) {
                NSDictionary *dic=[SJTool dictionaryWithResponse:response];
                NSLog(@"%@",[SJTool logDic:dic]);
                
                if ([dic[@"code"] intValue]==200) {
                    for (NSDictionary *dict in dic[@"data"][@"records"]) {
                        TipsListModel *model=[[TipsListModel alloc]initWithDictionary:dict];
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
        }else{
            NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"type":@(newOrHot),@"size":@(10),@"page":@(_page)};
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
        }
        
    }
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view .backgroundColor=kBackgroundColor;
    switch (self.index) {
        case 0:
            self.title=@"创意吧";
            break;
        case 1:
            self.title=@"项目库";
            break;
        default:
            self.title=@"找伙伴";
            break;
    }
    /**
    //
    NSArray *topSegmentTitle=@[@"最新",@"最热",@"小贴士"];
    self.topSegment=[[UISegmentedControl alloc]initWithItems:topSegmentTitle];
    self.topSegment.frame=CGRectMake(0, 0, kScreenWidth, 40);//CGRectMake(kScreenWidth/2-90, 0, 180, 40);
    self.topSegment.backgroundColor=kBackgroundColor;
    self.topSegment.tintColor=[UIColor clearColor];
    [self.topSegment setSelectedSegmentIndex:0];
    NSDictionary *textAttributes1=[NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                   [UIFont systemFontOfSize:18], NSFontAttributeName,
                                   nil];
    [self.topSegment setTitleTextAttributes:textAttributes1 forState:UIControlStateNormal];
    
    NSDictionary *textAttributes2=[NSDictionary dictionaryWithObjectsAndKeys:
                                   kThemeColor, NSForegroundColorAttributeName,
                                   [UIFont systemFontOfSize:18], NSFontAttributeName,
                                   nil];
    [self.topSegment setTitleTextAttributes:textAttributes2 forState:UIControlStateSelected];
    [self.topSegment addTarget:self action:@selector(topSelecte:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.topSegment];
    //
    UIView *segmentBottomLine=[[UIView alloc]initWithFrame:CGRectMake(0, self.topSegment.bottom-2, 60, 2)];//CGRectMake(self.topSegment.left, self.topSegment.bottom-2, 40, 2)
    segmentBottomLine.center=CGPointMake(kScreenWidth/6, segmentBottomLine.centerY);//self.topSegment.centerX-45
    segmentBottomLine.backgroundColor=kThemeColor;
    segmentBottomLine.tag=111111;
    [self.view addSubview:segmentBottomLine];
    //
    [self.view addSubview:self.tableView];
    */
    //
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
    
    //
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(kScreenWidth-75, self.tableView.bottom-75, 50, 50);
    switch (self.index) {
        case 0:
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"creativity_submitto"] forState:UIControlStateNormal];
            //[submitBtn setImage:[UIImage imageNamed:@"creativity_submitto"] forState:UIControlStateNormal];
            break;
        case 1:
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"project_submitto"] forState:UIControlStateNormal];
            //[submitBtn setImage:[UIImage imageNamed:@"project_submitto"] forState:UIControlStateNormal];
            break;
        default:
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"partner_submitto"] forState:UIControlStateNormal];
            //[submitBtn setImage:[UIImage imageNamed:@"partner_submitto"] forState:UIControlStateNormal];
            break;
    }
    submitBtn.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    submitBtn.layer.shadowOffset=CGSizeMake(0, 3);
    submitBtn.layer.shadowRadius=3;
    submitBtn.layer.shadowOpacity=1;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //[weakSelf getNewDataNewOrHot:(int)weakSelf.topSegment.selectedSegmentIndex+1];
        [weakSelf getNewDataWithCategoryId:weakSelf.categoryId];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{//MJRefreshBackFooter//MJRefreshAutoFooter
        
        //[weakSelf getMoreDataNewOrHot:(int)weakSelf.topSegment.selectedSegmentIndex+1];
        [weakSelf getMoreDataWithCategoryId:weakSelf.categoryId];
    }];
    
    //[self.tableView.mj_header beginRefreshing];
    
//    UISwipeGestureRecognizer *swipeGestureLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizerClick:)];
//    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:swipeGestureLeft];
//
//    UISwipeGestureRecognizer *swipeGestureRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizerClick:)];
//    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipeGestureRight];
}
/**
-(void)swipeGestureRecognizerClick:(UISwipeGestureRecognizer *)swipeGest{
    
    NSInteger index=self.topSegment.selectedSegmentIndex;
    UIView *view=[self.view viewWithTag:111111];
    
    if (swipeGest.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (index==2) {
            [self.topSegment setSelectedSegmentIndex:2];
            
        }else{
            [self.topSegment setSelectedSegmentIndex:index+1];
            [self.dataArr removeAllObjects];
            [self getNewDataNewOrHot:(int)self.topSegment.selectedSegmentIndex+1];
        }
        
    }
    if (swipeGest.direction==UISwipeGestureRecognizerDirectionRight) {
        if (index==0) {
            [self.topSegment setSelectedSegmentIndex:0];
            
        }else{
            [self.topSegment setSelectedSegmentIndex:index-1];
            [self.dataArr removeAllObjects];
            [self getNewDataNewOrHot:(int)self.topSegment.selectedSegmentIndex+1];
        }
        
    }
    view.center=CGPointMake(kScreenWidth*(2*self.topSegment.selectedSegmentIndex+1)/6, view.centerY);
    
    
}
*/
-(void)submitClick{
    NSLog(@"提交新的xxx");
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
            default:
            {
                SearchNumbersViewController *numbersVC=[SearchNumbersViewController new];
                [self.navigationController pushViewController:numbersVC animated:YES];
            }
                break;
        }
    }
    
}
/**
-(void)topSelecte:(UISegmentedControl *)segment{
    UIView *view=[self.view viewWithTag:111111];
    switch (self.topSegment.selectedSegmentIndex) {
        case 0:
        {
            view.center=CGPointMake(kScreenWidth/6, view.centerY);//self.topSegment.centerX-45
        }
            break;
        case 1:
        {
            view.center=CGPointMake(kScreenWidth/2, view.centerY);
        }
            break;
        default:
        {
            view.center=CGPointMake(kScreenWidth*5/6, view.centerY);//self.topSegment.centerX+45
            
        }
            break;
    }
    [self getNewDataNewOrHot:(int)self.topSegment.selectedSegmentIndex+1];
}
*/
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.bottom+10, kScreenWidth, kTableViewHeight-40-10) style:UITableViewStylePlain];//self.topSegment.bottom
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.categoryId==-2) {//self.topSegment.selectedSegmentIndex==2
        NSString *cellID=@"cellidenti";
        TipsListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[TipsListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.backgroundColor=[UIColor whiteColor];
        }
        cell.model=self.dataArr[indexPath.row];
        if (indexPath.row==self.dataArr.count-1) {
            cell.separaterLine.hidden=YES;
        }
        return cell;
    }else{
        if (self.index==2) {
            //找伙伴
            NSString *cellID=@"cellIdentifier";
            GotoSearchPeopleCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[GotoSearchPeopleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=kBackgroundColor;
            }
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }else{
            NSString *cellID=@"cellIdentifi";
            Hall_CreativityListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[Hall_CreativityListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.backgroundColor=kBackgroundColor;
            }
            
            cell.model=self.dataArr[indexPath.row];
            return cell;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.categoryId==-2) {//self.topSegment.selectedSegmentIndex==2
        CGFloat height=0;
        TipsListModel *model=self.dataArr[indexPath.row];
        height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TipsListCell class] contentViewWidth:kScreenWidth];
        return height;
    }else{
        if (self.index==2) {
            return 75;
        }
        return 100;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.categoryId==-2) {//self.topSegment.selectedSegmentIndex==2
        TipsListModel *model=self.dataArr[indexPath.row];
        TipsDetailViewController *tipVC=[TipsDetailViewController new];
        tipVC.shareContent=model.title;
        tipVC.urlString=model.url;
        [self.navigationController pushViewController:tipVC animated:YES];
    }else{
        if (self.index==2) {
            //找成员详情
            SearchNumbersDetailViewController *detailVC=[SearchNumbersDetailViewController new];
            SearchNumbersListModel_Hall *model=self.dataArr[indexPath.row];
            detailVC.Id=model.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            //找创意、项目详情
            CreativityAndProjectDetailViewController *detailVC=[CreativityAndProjectDetailViewController new];
            detailVC.index=self.index;
            SearchCreativityListModel *model=self.dataArr[indexPath.row];
            detailVC.Id=model.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
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
