//
//  ServeProgressViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeProgressViewController.h"
#import "ServeProgressModel.h"
#import "EvaluateViewController.h"
#import "ServeStatusCell.h"
#import "ServeDemandContentCell.h"
#import "ServeReplyContentCell.h"
#import "ServeEvaluateContentCell.h"
#import "DemandAlertView.h"
#import "SJAlertView.h"

@interface ServeProgressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ServeProgressModel *model;
@property(nonatomic,strong)UIButton *gotoEvaluate;
@property(nonatomic,strong)DemandAlertView *refuseAlertView;
@property(nonatomic,strong)SJAlertView *completeAlertView;

@end

@implementation ServeProgressViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)getData{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=nil;
    if (self.isUser) {
        param=@{@"user_token":token,@"userId":@(self.userId),@"demandId":@(self.demandId)};
    }else{
        param=@{@"user_token":token,@"demandId":@(self.demandId),@"providerId":@(self.providerId)};
    }
    [TDHttpTools serverDemandDetailWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if ([dic[@"data"] isKindOfClass:[NSDictionary class]]&& dic[@"data"]!=nil) {
               ServeProgressModel *model=[[ServeProgressModel alloc]initWithDictionary:dic[@"data"]];
                self.model=model;
                if (self.model.status==2 && self.isUser) {
                    //用户评价按钮
                    self.gotoEvaluate.hidden=NO;
                    [self.gotoEvaluate setTitle:@"评价" forState:UIControlStateNormal];
                }else if (self.model.status==0 && !self.isUser){
                    //服务商回复按钮
                    self.gotoEvaluate.hidden=NO;
                    [self.gotoEvaluate setTitle:@"回复" forState:UIControlStateNormal];
                }else if (self.model.status==1 && !self.isUser){
                    //服务商完成服务按钮
                    self.gotoEvaluate.hidden=NO;
                    [self.gotoEvaluate setTitle:@"服务完成" forState:UIControlStateNormal];
                }else{
                    self.gotoEvaluate.hidden=YES;
                }
            }
            [self.tableView reloadData];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    [self.view addSubview:self.tableView];
    
}
-(void)bottomBtnClick{
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    
    if (self.model.status==2 && self.isUser) {
        EvaluateViewController *evaluateVC=[EvaluateViewController new];
        evaluateVC.demandId=self.demandId;
        evaluateVC.providerId=self.providerId;
        [self.navigationController pushViewController:evaluateVC animated:YES];
    }else if (self.model.status==0 && !self.isUser){
        self.refuseAlertView=[[DemandAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        self.refuseAlertView.topLab.text=[NSString stringWithFormat:@"回复:%@",self.model.linker];
        self.refuseAlertView.detailLab.text=@"请确认您已与该用户进行过沟通，并达成共识。";
        WS(weakSelf);
        [self.refuseAlertView setSureBtnBlock:^{
            NSDictionary *param=@{@"user_token":user_token,@"id":@(weakSelf.model.Id),@"userId":@(weakSelf.model.userId),@"demand":weakSelf.model.demand,@"refuse":@"",@"status":@(1)};
            [weakSelf submitClick:param];
        }];
        [self.refuseAlertView setSureBtnBlock_2:^(NSString * _Nonnull refuse) {
            //
            NSDictionary *param=@{@"user_token":user_token,@"id":@(weakSelf.model.Id),@"userId":@(weakSelf.model.userId),@"demand":weakSelf.model.demand,@"refuse":refuse,@"status":@(4)};
            [weakSelf submitClick:param];
        }];
    }else if (self.model.status==1 && !self.isUser){
        self.completeAlertView=[[SJAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        self.completeAlertView.topLab.text=@"服务完成";
        self.completeAlertView.detailLab.text=@"请确认您的服务已真实有效完成，我们建议与用户沟通后再进行操作。";
        [self.completeAlertView.cancleBtn setTitle:@"再等等" forState:UIControlStateNormal];
        [self.completeAlertView.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        WS(weakSelf);
        [self.completeAlertView setSureBtnBlock:^{
            //
            NSDictionary *param=@{@"user_token":user_token,@"id":@(weakSelf.model.Id),@"userId":@(weakSelf.model.userId)};
            [weakSelf completeClick:param];
        }];
    }
    
}
-(void)submitClick:(NSDictionary *)param{
    
    [TDHttpTools providerReplyDemandWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self getData];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)completeClick:(NSDictionary *)param{
    
    [TDHttpTools providerCompleteWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self getData];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView=[self footerView];
    }
    return _tableView;
}
-(UIView *)footerView{
    UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    bg.backgroundColor=kBackgroundColor;
    //
    self.gotoEvaluate=[UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoEvaluate.frame=CGRectMake((kScreenWidth-96)/2, 10, 96, 40);
    [self.gotoEvaluate setTitle:@"评价" forState:UIControlStateNormal];
    [self.gotoEvaluate setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
    self.gotoEvaluate.titleLabel.font=[UIFont systemFontOfSize:14];
    self.gotoEvaluate.backgroundColor=kBackgroundColor;
    self.gotoEvaluate.layer.cornerRadius=4;
    self.gotoEvaluate.layer.borderWidth=1;
    self.gotoEvaluate.layer.borderColor=RGBAColor(0, 92, 175, 1).CGColor;
    self.gotoEvaluate.layer.masksToBounds=YES;
    self.gotoEvaluate.hidden=YES;
    [self.gotoEvaluate addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:self.gotoEvaluate];
    return bg;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model.status==0) {
        return 2;
    }else if (self.model.status==1){
        return 2;
    }else if (self.model.status==2){
        return 2;
    }else if (self.model.status==3){
        return 3;
    }else if (self.model.status==4){
        return 3;
    }else{
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSString *cellId=@"cellId1";
        ServeStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[ServeStatusCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.status=self.model.status;
        return cell;
    }else if (indexPath.section==1){
        NSString *cellId=@"cellId2";
        ServeDemandContentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[ServeDemandContentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.model=self.model;
        return cell;
    }else if (indexPath.section==2){
        if (self.model.status==3) {
            NSString *cellId=@"cellId3";
            ServeEvaluateContentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[ServeEvaluateContentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.model;
            return cell;
        }else if (self.model.status==4){
            NSString *cellId=@"cellId4";
            ServeReplyContentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[ServeReplyContentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.model=self.model;
            return cell;
        }
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 105;
    }else if (indexPath.section==1){
        CGFloat height=0;
        height=[tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[ServeDemandContentCell class] contentViewWidth:kScreenWidth];
        return height;
    }else if (indexPath.section==2){
        if (self.model.status==3) {
            CGFloat height=0;
            height=[tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[ServeEvaluateContentCell class] contentViewWidth:kScreenWidth];
            return height;
        }else if (self.model.status==4){
            CGFloat height=0;
            height=[tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model" cellClass:[ServeReplyContentCell class] contentViewWidth:kScreenWidth];
            return height;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
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
