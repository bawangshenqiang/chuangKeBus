//
//  ADBottomCustomView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2019/1/9.
//  Copyright © 2019年 qiyeji. All rights reserved.
//

#import "ADBottomCustomView.h"

@implementation ADBottomCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        //
        UILabel *bottomLab=[[UILabel alloc]init];
        bottomLab.text=@"创客巴士版权所有@2019";
        bottomLab.font=[UIFont systemFontOfSize:10];
        bottomLab.textColor=RGBAColor(153, 153, 153, 1);
        bottomLab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:bottomLab];
        //
        UIImageView *logo=[[UIImageView alloc]init];
        logo.image=[UIImage imageNamed:@"start_logo"];
        [self addSubview:logo];
        //
        UILabel *appName=[[UILabel alloc]init];
        appName.text=@"创客巴士";
        appName.font=[UIFont fontWithName:@"TRENDS" size:18];
        appName.textColor=[UIColor blackColor];
        [self addSubview:appName];
        
        //
        bottomLab.sd_layout
        .bottomSpaceToView(self, 21)
        .centerXEqualToView(self)
        .heightIs(14);
        [bottomLab setSingleLineAutoResizeWithMaxWidth:300];
        //
        logo.sd_layout
        .leftEqualToView(bottomLab)
        .bottomSpaceToView(bottomLab, 10)
        .widthIs(23)
        .heightIs(23);
        //
        appName.sd_layout
        .leftSpaceToView(logo, 6)
        .centerYEqualToView(logo)
        .heightIs(23);
        [appName setSingleLineAutoResizeWithMaxWidth:200];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
