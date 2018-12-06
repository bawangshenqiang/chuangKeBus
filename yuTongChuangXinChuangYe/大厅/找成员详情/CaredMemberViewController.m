//
//  CaredMemberViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CaredMemberViewController.h"
#import "AnimatTextFieldCell.h"
#import "AnimatTextViewCell.h"
#import "ContentModel.h"

@interface CaredMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ContentModel *contentModel;

@end

@implementation CaredMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"感兴趣";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCaredClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sureCaredClick)];
    
    ContentModel *contentModel=[[ContentModel alloc]init];
    contentModel.contents=@"";
    contentModel.cellHeight=60;
    self.contentModel=contentModel;
    
    [self.view addSubview:self.tableView];
}
-(void)cancelCaredClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sureCaredClick{
    AnimatTextFieldCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AnimatTextFieldCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AnimatTextFieldCell *cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AnimatTextViewCell *cell3=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (!cell0.textField.text.length) {
        [SJTool showAlertWithText:@"请输入姓名"];
        return;
    }
    if (!cell1.textField.text.length) {
        [SJTool showAlertWithText:@"请输入手机号"];
        return;
    }
    if (!cell2.textField.text.length) {
        [SJTool showAlertWithText:@"请输入期望职位"];
        return;
    }
    if (!cell3.textView.text.length) {
        [SJTool showAlertWithText:@"请输入个人简介"];
        return;
    }
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"findTeamUserId":@(self.Id),@"linker":cell0.textField.text,@"linkphone":cell1.textField.text,@"job":cell2.textField.text,@"description":cell3.textView.text};
    [self caredATeam:param];
}
-(void)caredATeam:(NSDictionary *)param{
    
    [TDHttpTools caredFindTeamWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if (self.callBackBlock) {
                self.callBackBlock();
            }
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            [self dismissViewControllerAnimated:YES completion:nil];
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
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        NSString *cellId=@"cellIdentifier1";
        AnimatTextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[AnimatTextFieldCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
        }
        NSArray *arr=@[@"姓名",@"手机号",@"期望职位"];
        cell.topLab.text=arr[indexPath.row];
        if (indexPath.row==1) {
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        }
        return cell;
    }else{
        NSString *cellId=@"cellIdentifier2";
        AnimatTextViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell=[[AnimatTextViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
        }
        
        cell.topLab.text=@"个人简介";
        cell.model=self.contentModel;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        return 60;
    }
    return self.contentModel.cellHeight;
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
