//
//  ChuangYiCellTopView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ChuangYiCellTopView.h"

@implementation ChuangYiCellTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 105, 75)];
        [self addSubview:_leftIV];
        //
        _rightLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, 10, frame.size.width-self.leftIV.right-20, 60)];
        _rightLab.numberOfLines=3;
        _rightLab.font=[UIFont systemFontOfSize:14];
        [self addSubview:_rightLab];
        //
        _flagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_flagBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        _flagBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _flagBtn.layer.borderColor=kThemeColor.CGColor;
        _flagBtn.layer.borderWidth=0.5;
        [self addSubview:_flagBtn];
        //
        _studyLab=[[UILabel alloc]init];
        _studyLab.font=[UIFont systemFontOfSize:12];
        _studyLab.textColor=[UIColor lightGrayColor];
        [self addSubview:_studyLab];
        //
        _separatorLine=[[UIView alloc]init];
        _separatorLine.backgroundColor=RGBAColor(145, 165, 165, 0.5);
        [self addSubview:_separatorLine];
        //
        _flagBtn.sd_layout
        .leftSpaceToView(self.leftIV, 10)
        .topSpaceToView(self.rightLab, 0);
        [_flagBtn setupAutoSizeWithHorizontalPadding:5 buttonHeight:15];
        //
        _studyLab.sd_layout
        .leftSpaceToView(self.flagBtn, 10)
        .topEqualToView(self.flagBtn)
        .heightIs(15);
        [_studyLab setSingleLineAutoResizeWithMaxWidth:150];
        //
        _separatorLine.sd_layout
        .leftEqualToView(self.leftIV)
        .rightEqualToView(self.rightLab)
        .topSpaceToView(self.leftIV, 9.5)
        .heightIs(0.5);
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
