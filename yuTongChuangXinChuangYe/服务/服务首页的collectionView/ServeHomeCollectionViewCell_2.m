//
//  ServeHomeCollectionViewCell_2.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeCollectionViewCell_2.h"
@interface ServeHomeCollectionViewCell_2 ()
@property(nonatomic,strong)UIImageView *bigIV;
@property(nonatomic,strong)UILabel *titleLab;

@end
@implementation ServeHomeCollectionViewCell_2
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bigIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-25)];
        self.bigIV.layer.borderWidth=0.5;
        self.bigIV.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.bigIV.layer.cornerRadius=5;
        self.bigIV.layer.masksToBounds=YES;
        [self addSubview:self.bigIV];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bigIV.bottom+10, frame.size.width, 15)];
        self.titleLab.font=[UIFont systemFontOfSize:12];
        self.titleLab.textColor=RGBAColor(50, 50, 50, 1);
        self.titleLab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
    }
    return self;
}
-(void)setModel:(StarCourseModel_Serve *)model{
    _model=model;
    [self.bigIV sd_setImageWithURL:[NSURL URLWithString:_model.picture]];
    self.titleLab.text=_model.title;
}
@end
