//
//  BottomView_Publish.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "BottomView_Publish.h"

@implementation BottomView_Publish
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        self.fontBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.fontBtn.frame=CGRectMake(20, 10, 20, 30);
        [self.fontBtn setImage:[UIImage imageNamed:@"publishtopic_bold"] forState:UIControlStateNormal];
        [self.fontBtn addTarget:self action:@selector(fontBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.fontBtn];
        //
        self.imageBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.imageBtn.frame=CGRectMake(self.fontBtn.right+15, 10, 36, 30);
        [self.imageBtn setImage:[UIImage imageNamed:@"publishtopic_picture"] forState:UIControlStateNormal];
        [self.imageBtn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageBtn];
        
    }
    return self;
}
-(void)fontBtnClick{
    if (self.fontBtnBlock) {
        self.fontBtnBlock();
    }
}
-(void)imageBtnClick{
    if (self.imageBtnBlock) {
        self.imageBtnBlock();
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
