//
//  CommentCell_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentCell_video.h"

@implementation CommentCell_video
-(void)setModel:(CommentModel_video *)model{
    _model=model;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.nickname;
    self.timeLab.text=_model.create_time;
    self.detailLab.text=_model.detail;
    self.line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    [self setupAutoHeightWithBottomView:self.line bottomMargin:0];
}
- (UIImageView *)headIV{
    if (!_headIV) {
        _headIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];
        [self.contentView addSubview:_headIV];
    }
    return _headIV;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headIV.right+10, 15, kScreenWidth-60, 15)];
        _nameLab.font=[UIFont systemFontOfSize:14];
        _nameLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_nameLab];
    }
    return _nameLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headIV.right+10, self.nameLab.bottom, kScreenWidth-60, 15)];
        _timeLab.font=[UIFont systemFontOfSize:10];
        _timeLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
        [self.contentView addSubview:_timeLab];
    }
    return _timeLab;
}
-(UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab=[[UILabel alloc]init];
        _detailLab.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_detailLab];
        _detailLab.sd_layout
        .leftEqualToView(self.nameLab)
        .topSpaceToView(self.timeLab, 15)
        .widthIs(kScreenWidth-60)
        .autoHeightRatio(0);
    }
    return _detailLab;
}
-(UIView *)line{
    if (!_line) {
        _line=[[UIView alloc]init];
        [self.contentView addSubview:_line];
        _line.sd_layout
        .leftEqualToView(self.detailLab)
        .topSpaceToView(self.detailLab, 15)
        .widthRatioToView(self.detailLab, 1)
        .heightIs(0.5);
    }
    return _line;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
