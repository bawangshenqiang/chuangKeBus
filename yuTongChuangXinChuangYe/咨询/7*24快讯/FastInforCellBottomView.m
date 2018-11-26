//
//  FastInforCellBottomView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "FastInforCellBottomView.h"

@implementation FastInforCellBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.detailLab=[[UILabel alloc]init];
        self.detailLab.font=[UIFont systemFontOfSize:14];
        self.detailLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self addSubview:self.detailLab];
        //
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.font=[UIFont systemFontOfSize:10];
        self.timeLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:self.timeLab];
        //
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:line];
        //
        self.fromLab=[[UILabel alloc]init];
        self.fromLab.font=[UIFont systemFontOfSize:10];
        self.fromLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:self.fromLab];
        //
        self.leftLine=[[UIView alloc]init];
        self.leftLine.backgroundColor=kThemeColor;
        [self addSubview:self.leftLine];
        //
//        self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.shareBtn setImage:[UIImage imageNamed:@"newsflash_repost"] forState:UIControlStateNormal];
//        [self addSubview:self.shareBtn];
        //
        self.detailLab.sd_layout
        .leftSpaceToView(self, 35)
        .topEqualToView(self)
        .widthIs(frame.size.width-35-10)
        .autoHeightRatio(0);
        self.timeLab.sd_layout
        .leftEqualToView(self.detailLab)
        .topSpaceToView(self.detailLab, 10)
        .heightIs(12);
        [self.timeLab setSingleLineAutoResizeWithMaxWidth:120];
        line.sd_layout
        .leftSpaceToView(self.timeLab, 5)
        .centerYEqualToView(self.timeLab)
        .widthIs(0.5)
        .heightIs(8);
        self.fromLab.sd_layout
        .leftSpaceToView(line, 5)
        .centerYEqualToView(self.timeLab)
        .heightIs(12);
        [self.fromLab setSingleLineAutoResizeWithMaxWidth:150];
        self.leftLine.sd_layout
        .leftSpaceToView(self, 17.5)
        .topEqualToView(self)
        .bottomEqualToView(self.timeLab)
        .widthIs(0.5);
//        self.shareBtn.sd_layout
//        .rightSpaceToView(self, 10)
//        .centerYEqualToView(self.timeLab)
//        .widthIs(13)
//        .heightIs(13);
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
