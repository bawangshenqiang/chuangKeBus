//
//  TastTop.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TastTop.h"

@implementation TastTop

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)RGBAColor(129, 99, 255, 1).CGColor, (__bridge id)RGBAColor(102, 162, 255, 1).CGColor];
        //, (__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor
        gradientLayer.locations = @[@0.0, @1.0];//, @0.5
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = frame;
        [self.layer addSublayer:gradientLayer];
        //
        UILabel *myTicket=[[UILabel alloc]init];//WithFrame:CGRectMake(24, (frame.size.height-15)/2, 70, 15)
        myTicket.text=@"我的车票:";
        myTicket.font=[UIFont systemFontOfSize:14];
        myTicket.textColor=RGBAColor(228, 228, 228, 1);
        [self addSubview:myTicket];
        //
        self.ticketCount=[[UILabel alloc]init];
        self.ticketCount.font=[UIFont systemFontOfSize:24];
        self.ticketCount.textColor=RGBAColor(228, 228, 228, 1);
        [self addSubview:self.ticketCount];
        //
        UIButton *center=[UIButton buttonWithType:UIButtonTypeCustom];
        center.frame=CGRectMake(frame.size.width-80-30, (frame.size.height-30)/2, 80, 30);
        [center setTitle:@"兑换中心" forState:UIControlStateNormal];
        [center setTitleColor:RGBAColor(228, 228, 228, 1) forState:UIControlStateNormal];
        center.backgroundColor=[UIColor clearColor];
        center.layer.borderWidth=1;
        center.layer.borderColor=RGBAColor(228, 228, 228, 1).CGColor;
        center.layer.cornerRadius=4;
        center.titleLabel.font=[UIFont systemFontOfSize:14];
        [center addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:center];
        //
        myTicket.sd_layout
        .leftSpaceToView(self, 24)
        .centerYEqualToView(self)
        .heightIs(15);
        [myTicket setSingleLineAutoResizeWithMaxWidth:80];
        //
        self.ticketCount.sd_layout
        .leftSpaceToView(myTicket, 8)
        .centerYIs(self.centerY-3)
        .heightIs(20);
        [self.ticketCount setSingleLineAutoResizeWithMaxWidth:150];
    }
    return self;
}
-(void)centerClick{
    if (self.centerClickBlock) {
        self.centerClickBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
