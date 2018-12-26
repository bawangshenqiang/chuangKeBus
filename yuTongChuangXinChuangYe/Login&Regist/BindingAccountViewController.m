//
//  BindingAccountViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "BindingAccountViewController.h"
#import "LoginCustomTF.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
extern BOOL receiveMessage;
@interface BindingAccountViewController ()
@property(nonatomic,strong)UILabel *titleLab;
/** 手机号 */
@property(nonatomic,strong)LoginCustomTF *customTF1;
/** 验证码 */
@property(nonatomic,strong)LoginCustomTF *customTF2;
/** 密码 */
@property(nonatomic,strong)LoginCustomTF *customTF3;
/** 同意协议按钮 */
@property(nonatomic,strong)UIButton *agree;

@end

@implementation BindingAccountViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //需要配合设置info.plist中的View controller-based status bar appearance 为NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    self.title=@"绑定账号";
    [self initUI];
    
}
-(void)initUI{
    UIImageView *backIV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-40)/2, 40*kBaseHeight, 40, 40)];
    backIV.image=[UIImage imageNamed:@"binding_yutong"];
    [self.view addSubview:backIV];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, backIV.bottom+10, kScreenWidth, 20)];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.text=@"创客巴士账号绑定";
    self.titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
    self.titleLab.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:self.titleLab];
    //手机号
    self.customTF1=[[LoginCustomTF alloc]initWithFrame:CGRectMake(40, self.titleLab.bottom+20*kBaseHeight, kScreenWidth-2*40, 40)];
    self.customTF1.leftIV.image=[UIImage imageNamed:@"binding_cellphone"];
    self.customTF1.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#989898"]}];
    self.customTF1.line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    self.customTF1.textField.keyboardType=UIKeyboardTypeNumberPad;
    self.customTF1.textField.textColor=[UIColor blackColor];
    [self.view addSubview:self.customTF1];
    //验证码
    self.customTF2=[[LoginCustomTF alloc]initWithFrame:CGRectMake(40, self.customTF1.bottom+15*kBaseHeight, kScreenWidth-2*40, 40)];
    self.customTF2.leftIV.image=[UIImage imageNamed:@"binding_verification"];
    self.customTF2.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#989898"]}];
    self.customTF2.line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    self.customTF2.authCodeBtn.hidden=NO;
    self.customTF2.lookBtn.hidden=YES;
    self.customTF2.textField.keyboardType=UIKeyboardTypeNumberPad;
    WS(weakSelf);
    [self.customTF2 setAuthCodeBtnBlock:^{
        [weakSelf getAuthCode];
    }];
    self.customTF2.textField.textColor=[UIColor blackColor];
    [self.view addSubview:self.customTF2];
    
    //密码
    self.customTF3=[[LoginCustomTF alloc]initWithFrame:CGRectMake(40, self.customTF2.bottom+15*kBaseHeight, kScreenWidth-2*40, 40)];
    self.customTF3.leftIV.image=[UIImage imageNamed:@"binding_password"];
    self.customTF3.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#989898"]}];
    self.customTF3.line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    self.customTF3.textField.secureTextEntry=YES;
    //[self.customTF3.textField setClearsOnBeginEditing:YES];
    [self.customTF3.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.customTF3.lookBtn.hidden=NO;
    [self.customTF3 setLookAtPwdBlock:^(BOOL flag) {
        weakSelf.customTF3.textField.secureTextEntry=!flag;
    }];
    self.customTF3.textField.textColor=[UIColor blackColor];
    [self.view addSubview:self.customTF3];
    
    //
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(50, self.customTF3.bottom+40*kBaseHeight, kScreenWidth-100, 40);
    [loginBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor=kThemeColor;
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    loginBtn.layer.cornerRadius=4;
    loginBtn.layer.masksToBounds=YES;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *annotation=[[UILabel alloc]init];
    annotation.text=@"如您还没有创客巴士账号，系统将自动为您注册并绑定";
    annotation.numberOfLines=0;
    annotation.font=[UIFont systemFontOfSize:10];
    annotation.textColor=[UIColor colorWithHexString:@"#989898"];
    [self.view addSubview:annotation];
    annotation.sd_layout
    .leftEqualToView(loginBtn)
    .topSpaceToView(loginBtn, 10*kBaseHeight)
    .widthIs(kScreenWidth-100)
    .autoHeightRatio(0);
    
    /**
    //用户协议、隐私政策
    self.agree=[UIButton buttonWithType:UIButtonTypeCustom];
    self.agree.frame=CGRectMake(loginBtn.left, loginBtn.bottom+10*kBaseHeight, 10, 10);
    [self.agree setImage:[UIImage imageNamed:@"register_notagreed"] forState:UIControlStateNormal];
    [self.agree setImage:[UIImage imageNamed:@"register_agree"] forState:UIControlStateSelected];
    [self.agree addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agree];
    //
    UILabel *lab1=[[UILabel alloc]init];
    lab1.text=@"注册即代表您同意";
    lab1.font=[UIFont systemFontOfSize:10];
    lab1.textColor=[UIColor colorWithHexString:@"#989898"];
    [self.view addSubview:lab1];
    lab1.sd_layout
    .leftSpaceToView(self.agree, 0)
    .topEqualToView(self.agree)
    .heightIs(10);
    [lab1 setSingleLineAutoResizeWithMaxWidth:100];
    
    //
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"#0384dd"] forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:10];
    [btn1 addTarget:self action:@selector(userAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    btn1.sd_layout
    .leftSpaceToView(lab1, 0)
    .topEqualToView(lab1);
    [btn1 setupAutoSizeWithHorizontalPadding:0 buttonHeight:10];
    //
    UILabel *lab2=[[UILabel alloc]init];
    lab2.text=@"和";
    lab2.font=[UIFont systemFontOfSize:10];
    lab2.textColor=[UIColor colorWithHexString:@"#989898"];
    [self.view addSubview:lab2];
    lab2.sd_layout
    .leftSpaceToView(btn1, 0)
    .topEqualToView(btn1)
    .heightIs(10);
    [lab2 setSingleLineAutoResizeWithMaxWidth:40];
    //
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"《隐私权政策》" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#0384dd"] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont systemFontOfSize:10];
    [btn2 addTarget:self action:@selector(userAgreement_2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    btn2.sd_layout
    .leftSpaceToView(lab2, 0)
    .topEqualToView(lab2);
    [btn2 setupAutoSizeWithHorizontalPadding:0 buttonHeight:10];
    */
}
#pragma mark 用户协议、隐私
-(void)userAgreement_2{
    NSLog(@"《隐私权政策》");
}
-(void)userAgreement{
    NSLog(@"《用户协议》");
}
#pragma mark 同意按钮
-(void)agreeClick{
    self.agree.selected=!self.agree.isSelected;
    
}
#pragma mark 登录
-(void)loginBtnClick{
//    if (!self.agree.selected) {
//        [SJTool showAlertWithText:@"请选择同意用户协议"];
//        return;
//    }
    if (!self.customTF1.textField.text.length) {
        [SJTool showAlertWithText:@"请输入手机号"];
        return;
    }
    if (!self.customTF2.textField.text.length) {
        [SJTool showAlertWithText:@"请输入验证码"];
        return;
    }
    if (!self.customTF3.textField.text.length) {
        [SJTool showAlertWithText:@"请输入密码"];
        return;
    }
    NSDictionary *param=@{@"telphone":self.customTF1.textField.text,@"password":self.customTF3.textField.text,@"code":self.customTF2.textField.text,@"openid":self.openid,@"ip":@"",@"name":self.name};
    [TDHttpTools bindingWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            
            if (self.fromSetPage) {
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            NSString *token=dic[@"data"][@"token"];
            NSNumber *userId=dic[@"data"][@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"TOKEN"];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"USERID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self getUserInfro];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark 获取验证码
-(void)getAuthCode{
    if (!self.customTF1.textField.text.length) {
        [SJTool showAlertWithText:@"请输入手机号"];
        return;
    }
    if (![SJTool isMobile:self.customTF1.textField.text]) {
        [SJTool showAlertWithText:@"手机号不正确"];
        return;
    }
    [TDHttpTools getAuthCodeWithParams:@{@"telphone":self.customTF1.textField.text} type:3 success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SJTool getAuthcodeClick:self.customTF2.authCodeBtn];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//获取个人信息
-(void)getUserInfro{
    //极光注册别名
    NSString *alias=[NSString stringWithFormat:@"%@phoenix",[[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"]];
    alias=[NSString md5:alias];
    
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode==0) {
            NSLog(@"设置别名成功：%@",iAlias);
            //9689f2b9691f481f35eda2fe5dd87a50
        }
    } seq:1];
    
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools getUserInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if ([dic[@"data"][@"message"] intValue]>0) {
                receiveMessage=YES;
            }
            NSDictionary *userDict = [dic[@"data"] copy];
            BOOL suc =  [userDict writeToFile:kAccountPath atomically:YES];
            if (suc){
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
