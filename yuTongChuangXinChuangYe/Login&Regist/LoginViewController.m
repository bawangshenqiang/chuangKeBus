//
//  LoginViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCustomTF.h"
#import "RegistViewController.h"
#import "AppDelegate.h"
#import "BindingAccountViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "JPUSHService.h"
extern BOOL receiveMessage;

@interface LoginViewController ()

@property(nonatomic,strong)UILabel *titleLab;
/** 手机号 */
@property(nonatomic,strong)LoginCustomTF *customTF1;
/** 密码/验证码 */
@property(nonatomic,strong)LoginCustomTF *customTF2;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //需要配合设置info.plist中的View controller-based status bar appearance 为NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}
-(void)initUI{
    UIImageView *backIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backIV.image=[UIImage imageNamed:@"login_background"];
    backIV.userInteractionEnabled=YES;
    [self.view addSubview:backIV];
    //
    UIButton *close=[UIButton buttonWithType:UIButtonTypeCustom];
    close.frame=CGRectMake(10, kStatusBarHeight+20*kBaseHeight, 20, 20);
    [close setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:close];
    //
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(40, close.bottom+55*kBaseHeight, 150, 20)];
    self.titleLab.text=@"密码登录";
    self.titleLab.textColor=[UIColor whiteColor];
    self.titleLab.font=[UIFont systemFontOfSize:28];
    [backIV addSubview:self.titleLab];
    //手机号
    self.customTF1=[[LoginCustomTF alloc]initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom+50*kBaseHeight, kScreenWidth-2*self.titleLab.left, 40)];
    self.customTF1.textField.keyboardType=UIKeyboardTypeNumberPad;
    [backIV addSubview:self.customTF1];
    //密码
    self.customTF2=[[LoginCustomTF alloc]initWithFrame:CGRectMake(self.titleLab.left, self.customTF1.bottom+15*kBaseHeight, kScreenWidth-2*self.titleLab.left, 40)];
    self.customTF2.leftIV.image=[UIImage imageNamed:@"login_password"];
    self.customTF2.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"]}];
    self.customTF2.textField.secureTextEntry=YES;
    //[self.customTF2.textField setClearsOnBeginEditing:YES];
    [self.customTF2.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.customTF2.lookBtn.hidden=NO;
    WS(weakSelf);
    [self.customTF2 setLookAtPwdBlock:^(BOOL flag) {
        weakSelf.customTF2.textField.secureTextEntry=!flag;
    }];
    [self.customTF2 setAuthCodeBtnBlock:^{
        [weakSelf getAuthCode];
    }];
    [backIV addSubview:self.customTF2];
    
    //
    UIButton *changeLoginType=[UIButton buttonWithType:UIButtonTypeCustom];
    changeLoginType.frame=CGRectMake(self.titleLab.left, self.customTF2.bottom+15*kBaseHeight, kScreenWidth/2-self.titleLab.left, 20);
    [changeLoginType setTitle:@"手机验证码登录>" forState:UIControlStateNormal];
    [changeLoginType setTitle:@"账号密码登录>" forState:UIControlStateSelected];
    [changeLoginType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeLoginType setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    changeLoginType.titleLabel.font=[UIFont systemFontOfSize:13];
    [changeLoginType addTarget:self action:@selector(changeLoginTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    changeLoginType.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [backIV addSubview:changeLoginType];
    
    //
    UIButton *forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame=CGRectMake(changeLoginType.right, changeLoginType.y, kScreenWidth/2-self.titleLab.left, 20);
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [backIV addSubview:forgetBtn];
    
    //
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake(50, changeLoginType.bottom+30*kBaseHeight, kScreenWidth-100, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor=kThemeColor;
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    loginBtn.layer.cornerRadius=4;
    loginBtn.layer.masksToBounds=YES;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:loginBtn];
    
    //
    UIView *line_left=[[UIView alloc]initWithFrame:CGRectMake(loginBtn.left, loginBtn.bottom+15+15*kBaseHeight, (loginBtn.width-50)/2, 0.5)];
    line_left.backgroundColor=[UIColor whiteColor];
    [backIV addSubview:line_left];
    //
    UIButton *weixin=[UIButton buttonWithType:UIButtonTypeCustom];
    weixin.frame=CGRectMake(line_left.right+10, loginBtn.bottom+15*kBaseHeight, 30, 30);
    [weixin setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [weixin addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:weixin];
    //
    UILabel *weixinLab=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-70)/2, weixin.bottom, 70, 20)];
    weixinLab.text=@"微信登录";
    weixinLab.font=[UIFont systemFontOfSize:12];
    weixinLab.textAlignment=NSTextAlignmentCenter;
    weixinLab.textColor=[UIColor whiteColor];
    [backIV addSubview:weixinLab];
    weixinLab.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weixinLogin)];
    [weixinLab addGestureRecognizer:tap];
    //
    UIView *line_right=[[UIView alloc]initWithFrame:CGRectMake(weixin.right+10, line_left.y, line_left.width, 0.5)];
    line_right.backgroundColor=[UIColor whiteColor];
    [backIV addSubview:line_right];
    
    //
    UIButton *registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame=CGRectMake(0, weixinLab.bottom+180*kBaseHeight, 150, 20);
    registBtn.center=CGPointMake(kScreenWidth/2, registBtn.centerY);
    NSMutableAttributedString *title=[[NSMutableAttributedString alloc]initWithString:@"没有账号？去注册>"];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 5)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0384dd"] range:NSMakeRange(5, title.length-5)];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, title.length)];
    [registBtn setAttributedTitle:title forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backIV addSubview:registBtn];
}
#pragma mark 注册
-(void)registBtnClick{
    RegistViewController *registVC=[RegistViewController new];
    registVC.isRegist=YES;
    [self.navigationController pushViewController:registVC animated:YES];
}
#pragma mark 微信登录
-(void)weixinLogin{
    NSLog(@"微信登录");
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             //
             //
             NSString *CName=[user.nickname copy];
             NSString *icon = [user.icon copy];
             
             //
             WS(weakSelf);
             [weakSelf thirdPartyLogin:user.uid cName:CName headImg:icon];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
}

-(void)thirdPartyLogin:(NSString*)openId cName:(NSString *)cname headImg:(NSString *)headImg{
    
     NSDictionary *param=@{@"openid":openId,@"ip":@""};
     [TDHttpTools loginWXWithParams:param success:^(id response) {
         NSDictionary *dic=[SJTool dictionaryWithResponse:response];
         NSLog(@"%@",[SJTool logDic:dic]);
         if ([dic[@"code"] intValue]==200) {
             NSString *token=dic[@"data"][@"token"];
             NSNumber *userId=dic[@"data"][@"userId"];
             [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"TOKEN"];
             [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"USERID"];
             [[NSUserDefaults standardUserDefaults] synchronize];
     
             [self getUserInfro];
         }else if ([dic[@"code"] intValue]==500301){
             //未绑定
             BindingAccountViewController *bingVC=[BindingAccountViewController new];
             bingVC.openid=openId;
             [self.navigationController pushViewController:bingVC animated:YES];
         }else{
             [SJTool showAlertWithText:dic[@"msg"]];
         }
     } failure:^(NSError *error) {
         NSLog(@"%@",error);
     }];
    
}
#pragma mark 登录
-(void)loginBtnClick{
    
//    AppDelegate *delega=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    [delega setupViewControllers];
    
    if (!self.customTF1.textField.text.length) {
        [SJTool showAlertWithText:@"请输入手机号"];
        return;
    }
    if (self.customTF2.authCodeBtn.hidden) {
        //密码登录
        if (!self.customTF2.textField.text.length) {
            [SJTool showAlertWithText:@"请输入密码"];
            return;
        }
        NSDictionary *param=@{@"telphone":self.customTF1.textField.text,@"password":self.customTF2.textField.text,@"ip":@""};
        [TDHttpTools loginWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
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
        
    }else{
        //验证码登录
        if (!self.customTF2.textField.text.length) {
            [SJTool showAlertWithText:@"请输入验证码"];
            return;
        }
        NSDictionary *param=@{@"telphone":self.customTF1.textField.text,@"code":self.customTF2.textField.text,@"ip":@""};
        [TDHttpTools loginWithCodeWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
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
#pragma mark 忘记密码
-(void)forgetBtnClick{
    RegistViewController *registVC=[RegistViewController new];
    [self.navigationController pushViewController:registVC animated:YES];
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
    [TDHttpTools getAuthCodeWithParams:@{@"telphone":self.customTF1.textField.text} type:0 success:^(id response) {
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
#pragma mark 切换登录方式
-(void)changeLoginTypeClick:(UIButton *)btn{
    btn.selected=!btn.isSelected;
    if (btn.selected) {
        self.titleLab.text=@"验证码登录";
        self.customTF2.leftIV.image=[UIImage imageNamed:@"verification_verification"];
        self.customTF2.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"]}];
        self.customTF2.textField.secureTextEntry=NO;
        self.customTF2.lookBtn.hidden=YES;
        self.customTF2.authCodeBtn.hidden=NO;
        self.customTF2.textField.text=@"";
        self.customTF2.textField.keyboardType=UIKeyboardTypeNumberPad;
    }else{
        self.titleLab.text=@"密码登录";
        self.customTF2.leftIV.image=[UIImage imageNamed:@"login_password"];
        self.customTF2.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"]}];
        self.customTF2.authCodeBtn.hidden=YES;
        self.customTF2.lookBtn.hidden=NO;
        self.customTF2.textField.keyboardType=UIKeyboardTypeDefault;
        self.customTF2.textField.secureTextEntry=YES;
        self.customTF2.lookBtn.selected=NO;
        self.customTF2.textField.text=@"";
        
    }
}
#pragma mark 关闭按钮
-(void)closeBtnClick{
    NSLog(@"关闭");
    [self dismissViewControllerAnimated:YES completion:nil];
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
