//
//  ServeHomeCollectionViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeCollectionViewCell.h"
@interface ServeHomeCollectionViewCell ()
@property(nonatomic,strong)UIImageView *bigIV;
@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation ServeHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bigIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
        self.bigIV.layer.cornerRadius=5;
        self.bigIV.layer.masksToBounds=YES;
        [self addSubview:self.bigIV];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bigIV.bottom+10, frame.size.width, 30)];
        self.titleLab.font=[UIFont systemFontOfSize:12];
        self.titleLab.textColor=RGBAColor(50, 50, 50, 1);
        self.titleLab.numberOfLines=2;
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
