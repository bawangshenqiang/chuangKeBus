//
//  SystemHallViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemHallViewController.h"
#import "SystemHallFirstCell.h"
#import "SystemHallSecondCell.h"
#import "HuaShanListModel.h"
#import "HuaShanCell_First.h"
#import "SectionHeader_SystemHall.h"
#import "PublishThemeViewController.h"
#import "HuaShanDetailViewController.h"

#import "HuaShanTitleCell_HallFirst.h"
#import "LoginViewController.h"

@interface SystemHallViewController ()<UITableViewDelegate,UITableViewDataSource,LMJDropdownMenuDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)NSDictionary *categoryDic;
@property(nonatomic,strong)NSMutableArray *tops;//置顶

@end

@implementation SystemHallViewController
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
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
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"blockId":@(0),@"themeId":@(self.themeId),@"type":@(self.type)};
    [TDHttpTools systemHallListWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        [self.dataArr removeAllObjects];
        if ([dic[@"code"] intValue]==200) {
            for (NSDictionary *dict in dic[@"data"][@"pageView"][@"records"]) {
                HuaShanListModel *model=[[HuaShanListModel alloc]initWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            self.categoryDic=dic[@"data"][@"category"];
            self.tops=dic[@"data"][@"tops"];
            
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
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"size":@(10),@"page":@(_page),@"user_token":user_token,@"blockId":@(0),@"themeId":@(self.themeId),@"type":@(self.type)};
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    [self.view addSubview:self.tableView];
    
    self.type=3;
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf getNewData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        [weakSelf getMoreData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    if ([self.title isEqualToString:@"创意交流"]) {
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
    
    
}
-(void)submitClick{
    NSLog(@"发表主题");
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
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView=[UIView new];
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NSString *cellID1=@"cellIdentifier1";
            SystemHallFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
            if (!cell) {
                cell=[[SystemHallFirstCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
                
            }
            [cell.headIV sd_setImageWithURL:[NSURL URLWithString:self.categoryDic[@"icon"]] placeholderImage:nil];//[UIImage imageNamed:@"hall_user"]
            cell.titleLab.text=self.categoryDic[@"note"];
            return cell;
        }else{
            NSString *cellID2=@"cellIdentifier2";
            SystemHallSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell) {
                cell=[[SystemHallSecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID2];
                
            }
            if (self.tops.count==2) {
                cell.modelDic=self.tops[indexPath.row-1];
            }
            if (indexPath.row==1) {
                cell.line.hidden=NO;
            }else{
                cell.line.hidden=YES;
            }
            return cell;
        }
    }else{
        NSString *cellID=@"cellIdentifier";
        HuaShanTitleCell_HallFirst *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[HuaShanTitleCell_HallFirst alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.backgroundColor=[UIColor whiteColor];
            
        }
        cell.model=self.dataArr[indexPath.row];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else{
            return 45;
        }
    }else{
        HuaShanListModel *model=self.dataArr[indexPath.row];
        CGFloat height=[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[HuaShanTitleCell_HallFirst class] contentViewWidth:kScreenWidth];
        return height;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head=[[UIView alloc]init];
    if (section==1) {
        SectionHeader_SystemHall *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (!header) {
            header=[[SectionHeader_SystemHall alloc]initWithReuseIdentifier:@"header"];
        }
        header.choseStyle.delegate=self;
        
        head=header;
    }
    
    return head;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else{
       return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row!=0) {
            if (self.tops.count==2) {
                NSDictionary *dic=self.tops[indexPath.row-1];
                HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
                detailVC.postId=[dic[@"id"] intValue];
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
    }else{
        HuaShanListModel *model=self.dataArr[indexPath.row];
        HuaShanDetailViewController *detailVC=[HuaShanDetailViewController new];
        detailVC.postId=model.Id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    self.type=(int)number+3;
    [self getNewData];
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
