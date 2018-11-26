//
//  ResourceLeftCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceLeftCell.h"

@implementation ResourceLeftCell

-(void)setLeftModel:(ResourceLeftModel *)leftModel{
    _leftModel=leftModel;
    self.titleLab.text=_leftModel.title;
//    if (_leftModel.selected) {
//        self.titleLab.textColor=kThemeColor;
//    }else{
//        self.titleLab.textColor=[UIColor blackColor];
//    }
    [self setupAutoHeightWithBottomView:self.titleLab bottomMargin:10];
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:16];
        _titleLab.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        _titleLab.sd_layout
        .leftSpaceToView(self.contentView, 8)
        .topSpaceToView(self.contentView, 10)
        .widthIs(35)
        .autoHeightRatio(0);
        
    }
    return _titleLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 if (selected) {
 self.titleLab.textColor=kThemeColor;
 }else{
 self.titleLab.textColor=[UIColor blackColor];
 }
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.titleLab.textColor=kThemeColor;
        self.titleLab.font=[UIFont boldSystemFontOfSize:16];
    }else{
        self.titleLab.textColor=[UIColor blackColor];
        self.titleLab.font=[UIFont systemFontOfSize:16];
    }
    
}

@end
