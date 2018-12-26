//
//  CustomNavi.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CustomNavi.h"

@implementation CustomNavi
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, kStatusBarHeight)];
        topBackground.backgroundColor=kThemeColor;
        [self addSubview:topBackground];
       //
        UIView *bottomBackground=[[UIView alloc]initWithFrame:CGRectMake(0, topBackground.bottom, frame.size.width, 44)];
        bottomBackground.backgroundColor=[UIColor whiteColor];//kThemeColor;//
        [self addSubview:bottomBackground];
        //
        UIButton *outBig=[UIButton buttonWithType:UIButtonTypeCustom];
        //outBig.frame=CGRectMake(10, 7, frame.size.width-50, 30);
        
        [outBig setImage:[UIImage imageNamed:@"hall_search"] forState:UIControlStateNormal];
        [outBig setTitle:@"搜索你需要的内容" forState:UIControlStateNormal];
        [outBig setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
        outBig.titleLabel.font=[UIFont systemFontOfSize:13];
        
        outBig.backgroundColor=RGBAColor(247, 247, 247, 1);
        outBig.layer.cornerRadius=5;
        outBig.layer.masksToBounds=YES;
        [outBig addTarget:self action:@selector(choseClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomBackground addSubview:outBig];
        
        //
        self.messageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.messageBtn setImage:[UIImage imageNamed:@"hall_new"] forState:UIControlStateNormal];
        
        [self.messageBtn addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bottomBackground addSubview:self.messageBtn];
        //
        self.redDot=[[UIView alloc]init];
        self.redDot.backgroundColor=[UIColor redColor];
        self.redDot.hidden=YES;
        [bottomBackground addSubview:self.redDot];
        
        //
        outBig.sd_layout
        .leftSpaceToView(bottomBackground, 11)
        .topSpaceToView(bottomBackground, 8)
        .widthIs(frame.size.width-71)
        .heightIs(28);
        
        outBig.imageView.sd_layout
        .leftSpaceToView(outBig, 8)
        .topSpaceToView(outBig, 7)
        .widthIs(14)
        .heightIs(14);
        
        outBig.titleLabel.sd_layout
        .leftSpaceToView(outBig.imageView, 9)
        .topEqualToView(outBig)
        .widthIs(160)
        .heightIs(28);
        
        
        self.messageBtn.sd_layout
        .leftSpaceToView(outBig, 0)
        .topSpaceToView(bottomBackground, 7)
        .widthIs(60)
        .heightIs(30);
        
        self.redDot.sd_layout
        .rightSpaceToView(bottomBackground, 10)
        .topSpaceToView(bottomBackground, 10)
        .widthIs(6)
        .heightIs(6);
        self.redDot.sd_cornerRadius=@(3);
        
        
    }
    return self;
}
-(void)messageBtnClick{
    if (self.TouchMessageBlock) {
        self.TouchMessageBlock();
    }
}
-(void)choseClick{
    if (self.TouchSearchBlock) {
        self.TouchSearchBlock();
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
