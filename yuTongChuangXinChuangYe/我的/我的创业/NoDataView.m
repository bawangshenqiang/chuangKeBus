//
//  NoDataView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-170)/2, 0, 170, 160)];
        imageView.image=[UIImage imageNamed:@"allPages_notyet"];
        [self addSubview:imageView];
        //
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, frame.size.width, 40)];
        label.text=@"暂无数据";
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithHexString:@"#323232"];
        [self addSubview:label];
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
