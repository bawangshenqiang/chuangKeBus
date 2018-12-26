//
//  TaskCenterSectionHeader.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TaskCenterSectionHeader.h"

@implementation TaskCenterSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.leftLab=[[UILabel alloc]init];
        self.leftLab.font=[UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:self.leftLab];
        //
        self.rightLab=[[UILabel alloc]init];
        self.rightLab.font=[UIFont systemFontOfSize:12];
        self.rightLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:self.rightLab];
        //
        self.foldIV=[[UIImageView alloc]init];
        self.foldIV.image=[UIImage imageNamed:@"task_arrow"];
        self.foldIV.transform=CGAffineTransformMakeRotation(M_PI);
        [self.contentView addSubview:self.foldIV];
        //
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=RGBAColor(165, 165, 165, 0.5);
        [self.contentView addSubview:line];
        //
        self.leftLab.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 18)
        .heightIs(14);
        [self.leftLab setSingleLineAutoResizeWithMaxWidth:100];
        //
        self.rightLab.sd_layout
        .leftSpaceToView(self.leftLab, 15)
        .centerYEqualToView(self.leftLab)
        .heightIs(14);
        [self.rightLab setSingleLineAutoResizeWithMaxWidth:250];
        //
        self.foldIV.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.leftLab)
        .widthIs(15)
        .heightIs(15);
        //
        line.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(self.contentView, 46.5)//总高度是47
        .heightIs(0.5);
        //
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flowClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)setModel:(TaskCenterHeaderModel *)model{
    _model=model;
    self.leftLab.text=_model.title;
    self.rightLab.text=_model.subTitle;
    if (_model.folding) {
        self.foldIV.transform=CGAffineTransformIdentity;
    }else{
        self.foldIV.transform=CGAffineTransformMakeRotation(M_PI);
    }
}
-(void)flowClick{
    _model.folding=!_model.folding;
    if (self.foldClickBlock) {
        self.foldClickBlock(self.taag);
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
