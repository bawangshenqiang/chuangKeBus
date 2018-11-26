//
//  LoginCustomTF.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "LoginCustomTF.h"

@implementation LoginCustomTF
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyBoard) name:@"DismissKeyBoard" object:nil];
        
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 11, 14)];//
        self.leftIV.image=[UIImage imageNamed:@"login_cellphone"];
        [self addSubview:self.leftIV];
        //
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(self.leftIV.right, 8, frame.size.width-self.leftIV.width-90, 20)];
        self.textField.font=[UIFont systemFontOfSize:18];
        //self.textField.placeholder=@"请输入手机号";
        self.textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#cccccc"]}];
        self.textField.textColor=[UIColor whiteColor];
        [self.textField setInputAccessoryView:[SJTool backToolBarView]];
        self.textField.leftView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        self.textField.leftViewMode=UITextFieldViewModeAlways;
        [self addSubview:self.textField];
        //
        self.line=[[UIView alloc]initWithFrame:CGRectMake(0, self.textField.bottom+8, frame.size.width, 0.5)];
        self.line.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.line];
        //
        self.leftIV.center=CGPointMake(self.leftIV.centerX, self.textField.centerY);
        //
        self.lookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.lookBtn.frame=CGRectMake(frame.size.width-30, self.leftIV.y, 30, 30);
        [self.lookBtn setImage:[UIImage imageNamed:@"login_invisible"] forState:UIControlStateNormal];
        [self.lookBtn setImage:[UIImage imageNamed:@"login_visual"] forState:UIControlStateSelected];
        [self.lookBtn addTarget:self action:@selector(lookAtPwd) forControlEvents:UIControlEventTouchUpInside];
        self.lookBtn.hidden=YES;
        self.lookBtn.center=CGPointMake(self.lookBtn.centerX, self.leftIV.centerY);
        [self addSubview:self.lookBtn];
        //
        self.authCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.authCodeBtn.frame=CGRectMake(self.textField.right, self.textField.y, 90, 20);
        [self.authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.authCodeBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        self.authCodeBtn.titleLabel.font=[UIFont systemFontOfSize:17]; self.authCodeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self.authCodeBtn addTarget:self action:@selector(authCodeClick) forControlEvents:UIControlEventTouchUpInside];
        self.authCodeBtn.hidden=YES;
        [self addSubview:self.authCodeBtn];
        
    }
    return self;
}
-(void)authCodeClick{
    if (self.authCodeBtnBlock) {
        self.authCodeBtnBlock();
    }
}
-(void)lookAtPwd{
    self.lookBtn.selected=!self.lookBtn.isSelected;
    if (self.lookAtPwdBlock) {
        self.lookAtPwdBlock(self.lookBtn.isSelected);
    }
}
-(void) dismissKeyBoard{
    [self endEditing:YES];
}
-(void)dealloc{
    
    [kNotificationCenter removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
