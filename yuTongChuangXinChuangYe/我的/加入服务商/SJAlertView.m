//
//  SJAlertView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SJAlertView.h"

@implementation SJAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shadeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shadeView.backgroundColor=RGBAColor(0, 0, 0, 0.5);
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.shadeView];
        
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, frame.size.height)];
        self.bigView.center=CGPointMake(self.bigView.centerX, kScreenHeight/2);
        
        self.bigView.layer.cornerRadius=5;
        self.bigView.layer.masksToBounds=YES;
        self.bigView.backgroundColor=kThemeColor;
        [self.shadeView addSubview:self.bigView];
        
        //
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0ca4eb"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor];
//        gradientLayer.locations = @[@0.0, @0.5, @1.0];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0);
//        gradientLayer.frame = self.bigView.frame;
//        [self.layer addSublayer:gradientLayer];
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
        self.cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleBtn.frame=CGRectMake(0, self.detailLab.bottom, self.bigView.width/2, 40);
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
        self.cancleBtn.backgroundColor=[UIColor whiteColor];
        self.cancleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        self.cancleBtn.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.cancleBtn.layer.borderWidth=0.4;
        [self.cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.cancleBtn];
        //
        self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame=CGRectMake(self.cancleBtn.right, self.detailLab.bottom, self.bigView.width/2, 40);
        [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        self.sureBtn.backgroundColor=[UIColor whiteColor];
        self.sureBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        self.sureBtn.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.sureBtn.layer.borderWidth=0.4;
        [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.sureBtn];
        
        
        
        self.bigView.transform=CGAffineTransformMakeScale(0.01, 0.01);
        [self show];
    }
    return self;
}
-(void)cancleClick{
    
    [self dismiss];
}
-(void)sureClick{
    if (self.sureBtnBlock) {
        self.sureBtnBlock();
    }
    [self dismiss];
}
-(void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.bigView.transform=CGAffineTransformMakeScale(1, 1);
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.bigView.transform=CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [self.bigView removeFromSuperview];
        [self.shadeView removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
