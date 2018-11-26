//
//  ChangeLoginPWDViewController.m
//  客户KR管理系统
//
//  Created by 霸枪001 on 2018/9/18.
//  Copyright © 2018年 corill002. All rights reserved.
//

#import "ChangeLoginPWDViewController.h"

@interface ChangeLoginPWDViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *oldPwd;
@property(nonatomic,strong)UITextField *currentPwd;

@end

@implementation ChangeLoginPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改登录密码";
    self.view.backgroundColor=kBackgroundColor;
    [self initUI];
}
-(void)initUI{
    self.oldPwd=[[UITextField alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 50)];
    self.oldPwd.backgroundColor=[UIColor whiteColor];
    self.oldPwd.font=[UIFont systemFontOfSize:17];
    self.oldPwd.placeholder=@"请输入旧密码";
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    lab1.text=@"旧密码";
    lab1.font=[UIFont systemFontOfSize:17];
    lab1.textAlignment=NSTextAlignmentCenter;
    self.oldPwd.leftView=lab1;
    self.oldPwd.leftViewMode=UITextFieldViewModeAlways;
    self.oldPwd.delegate=self;
    self.oldPwd.secureTextEntry=YES;
    [self.view addSubview:self.oldPwd];
    //
    self.currentPwd=[[UITextField alloc]initWithFrame:CGRectMake(0, self.oldPwd.bottom+20, kScreenWidth, 50)];
    self.currentPwd.backgroundColor=[UIColor whiteColor];
    self.currentPwd.font=[UIFont systemFontOfSize:17];
    self.currentPwd.placeholder=@"请输入新密码";
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    lab2.text=@"新密码";
    lab2.font=[UIFont systemFontOfSize:17];
    lab2.textAlignment=NSTextAlignmentCenter;
    self.currentPwd.leftView=lab2;
    self.currentPwd.leftViewMode=UITextFieldViewModeAlways;
    self.currentPwd.delegate=self;
    self.currentPwd.secureTextEntry=YES;
    [self.view addSubview:self.currentPwd];
    //
    UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(15, self.currentPwd.bottom+40, kScreenWidth-30, 50);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:kThemeColor];
    sureBtn.layer.cornerRadius=4;
    sureBtn.layer.masksToBounds=YES;
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}
-(void)sureClick{
    if (!self.oldPwd.text.length) {
        [SJTool showAlertWithText:@"请输入旧密码"];
        return;
    }
    if (!self.currentPwd.text.length) {
        [SJTool showAlertWithText:@"请输入新密码"];
        return;
    }else{
        NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
        NSDictionary *param=@{@"user_token":token,@"oldpassword":self.oldPwd.text,@"password":self.currentPwd.text};
        [TDHttpTools changePwdWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
                
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SJTool showAlertWithText:dic[@"msg"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
