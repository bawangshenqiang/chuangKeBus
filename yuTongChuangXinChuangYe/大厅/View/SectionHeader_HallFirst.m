//
//  SectionHeader_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SectionHeader_HallFirst.h"

@implementation SectionHeader_HallFirst
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=kBackgroundColor;
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        self.leftIV.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:self.leftIV];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, 0, 100, 40)];
        self.titleLab.font=[UIFont boldSystemFontOfSize:20];
        [self addSubview:self.titleLab];
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
