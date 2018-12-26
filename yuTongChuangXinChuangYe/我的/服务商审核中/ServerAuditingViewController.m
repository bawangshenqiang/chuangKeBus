//
//  ServerAuditingViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServerAuditingViewController.h"
#import "JoinServerViewController.h"
#import "JoinServerModel.h"
#import "ServeAuditingFirstCell.h"
#import "ServeAuditingSecondCell.h"
#import "ServeAuditingThirdCell.h"


@interface ServerAuditingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JoinServerModel *model;

@end

@implementation ServerAuditingViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"加入服务商";
    self.view.backgroundColor=kBackgroundColor;
    
    
    
    [self.view addSubview:self.tableView];
    
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"user_token":user_token};
    
    [TDHttpTools providerInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if (![dic[@"data"] isKindOfClass:[NSNull class]]&&dic[@"data"]!=nil) {
                self.model=[[JoinServerModel alloc]initWithDictionary:dic[@"data"]];
                if (self.model.status==2) {
                    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
                }else{
                    self.navigationItem.rightBarButtonItem=nil;
                }
                [self.tableView reloadData];
                
            }
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark 编辑
-(void)rightBarClick{
    //状态 0-新添加 1-已审核 2-待修改 3-已修改
    JoinServerViewController *vc=[JoinServerViewController new];
    vc.Id=self.model.Id;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model) {
        if (self.model.status!=2){
            return 2;
        }else{
            return 3;
        }
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSString *cellId=@"cellId1";
        ServeAuditingFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[ServeAuditingFirstCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=kBackgroundColor;
        }
        cell.model=self.model;
        return cell;
    }else if (indexPath.section==1){
        NSString *cellId=@"cellId2";
        ServeAuditingSecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[ServeAuditingSecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=kBackgroundColor;
        }
        cell.model=self.model;
        return cell;
    }else{
        NSString *cellId=@"cellId3";
        ServeAuditingThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[ServeAuditingThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=kBackgroundColor;
        }
        cell.model=self.model;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }else if (indexPath.section==1){
        return 90;
    }else if (indexPath.section==2){
        CGFloat height=0;
        height=[tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[ServeAuditingThirdCell class] contentViewWidth:kScreenWidth];
        return height;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
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
