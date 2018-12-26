//
//  DemandAlertView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "DemandAlertView.h"

@implementation DemandAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
        //
        self.shadeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shadeView.backgroundColor=RGBAColor(0, 0, 0, 0.5);
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.shadeView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeShadeView)];
        [self.shadeView addGestureRecognizer:tap];
        
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, frame.size.height)];
        self.bigView.center=CGPointMake(self.bigView.centerX, kScreenHeight/2-20);
        
        //
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0ca4eb"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor];
        self.gradientLayer.locations = @[@0.0, @0.5, @1.0];
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1.0, 0);
        self.gradientLayer.frame = self.bigView.frame;
        self.gradientLayer.cornerRadius=5;
        self.gradientLayer.masksToBounds=YES;
        [self.shadeView.layer addSublayer:self.gradientLayer];
        
        self.bigView.layer.cornerRadius=5;
        self.bigView.layer.masksToBounds=YES;
        //self.bigView.backgroundColor=kThemeColor;
        [self.shadeView addSubview:self.bigView];
        
        //
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.bigView.width-25, 40)];
        self.topLab.backgroundColor=[UIColor clearColor];
        self.topLab.font=[UIFont boldSystemFontOfSize:14];
        self.topLab.textColor=[UIColor whiteColor];
        [self.bigView addSubview:self.topLab];
        //
        UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topLab.bottom, self.bigView.width, 90)];
        centerView.backgroundColor=[UIColor whiteColor];
        [self.bigView addSubview:centerView];
        //
        self.detailLab=[[UILabel alloc]initWithFrame:CGRectMake(20, self.topLab.bottom, self.bigView.width-40, 90)];
        self.detailLab.backgroundColor=[UIColor whiteColor];
        self.detailLab.textAlignment=NSTextAlignmentCenter;
        self.detailLab.numberOfLines=0;
        self.detailLab.textColor=[UIColor blackColor];
        self.detailLab.font=[UIFont systemFontOfSize:16];
        [self.bigView addSubview:self.detailLab];
        //
        self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10, self.topLab.bottom, self.bigView.width-20, 90)];
        self.textView.font=[UIFont systemFontOfSize:14];
        self.textView.textColor=RGBAColor(102, 102, 102, 1);
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请写下您拒绝的合理理由...";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [self.textView addSubview:placeHolderLabel];
        placeHolderLabel.font = [UIFont systemFontOfSize:14];
        [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        [self.textView setInputAccessoryView:[SJTool backToolBarView]];
        self.textView.hidden=YES;
        [self.bigView addSubview:self.textView];
        //
        self.cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleBtn.frame=CGRectMake(0, self.detailLab.bottom, self.bigView.width/2, 40);
        [self.cancleBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
        self.cancleBtn.backgroundColor=[UIColor whiteColor];
        self.cancleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        self.cancleBtn.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.cancleBtn.layer.borderWidth=0.4;
        [self.cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.cancleBtn];
        //
        self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame=CGRectMake(self.cancleBtn.right, self.detailLab.bottom, self.bigView.width/2, 40);
        [self.sureBtn setTitle:@"接收" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        self.sureBtn.backgroundColor=[UIColor whiteColor];
        self.sureBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        self.sureBtn.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.sureBtn.layer.borderWidth=0.4;
        [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.sureBtn];
        
        //
        self.shadeView.transform=CGAffineTransformMakeScale(0.01, 0.01);
        [self show];
    }
    return self;
}
-(void)cancleClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"拒绝"]) {
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        self.detailLab.hidden=YES;
        self.textView.hidden=NO;
        [self.textView becomeFirstResponder];
    }else{
        [self.textView resignFirstResponder];
        self.textView.hidden=YES;
        self.detailLab.hidden=NO;
        [self.cancleBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.sureBtn setTitle:@"接收" forState:UIControlStateNormal];
    }
}
-(void)sureClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"接收"]) {
        if (self.sureBtnBlock) {
            self.sureBtnBlock();
        }
        [self dismiss];
    }else{
        if (!self.textView.text.length) {
            [SJTool showAlertWithText:@"必须填写理由"];
            return;
        }
        if (self.sureBtnBlock_2) {
            self.sureBtnBlock_2(self.textView.text);
        }
        [self dismiss];
    }
    
}
-(void)show{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.shadeView.transform=CGAffineTransformMakeScale(1, 1);
        
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.shadeView.transform=CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.gradientLayer removeFromSuperlayer];
        [self.bigView removeFromSuperview];
        [self.shadeView removeFromSuperview];
    }];
}
-(void)closeShadeView{
    [self dismiss];
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textView endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
