//
//  Header_UserInfo.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Header_UserInfo.h"

@implementation Header_UserInfo
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.headIV=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 10, 100, 100)];
        self.headIV.layer.cornerRadius=50;
        self.headIV.layer.masksToBounds=YES;
        self.headIV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setImageClick)];
        [self.headIV addGestureRecognizer:tap];
        [self addSubview:self.headIV];
    }
    return self;
}
-(void)setImageClick{
    if (self.setImageBlock) {
        self.setImageBlock();
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
