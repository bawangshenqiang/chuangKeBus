//
//  HuaShanCell_First.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanCell_First.h"

@implementation HuaShanCell_First

-(void)setModel:(HuaShanListModel *)model{
    _model=model;
    [self.headerIV sd_setImageWithURL:[NSURL URLWithString:_model.headerUrl] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.name;
    self.timeLab.text=_model.time;
    self.titleLab.text=_model.title;
    //self.subtitleLab.text=_model.subtitle;
    //[self.bigIV sd_setImageWithURL:[NSURL URLWithString:_model.bigImgUrl] placeholderImage:[UIImage imageNamed:@"listing"]];
    self.commentIV.image=[UIImage imageNamed:@"hall_comment"];
    self.commentLab.text=[NSString stringWithFormat:@"%d",_model.comment];
    self.praiseIV.image=[UIImage imageNamed:@"hall_snap"];
    self.praiseLab.text=[NSString stringWithFormat:@"%d",_model.praise];
    self.separaterView.backgroundColor=kBackgroundColor;
    [self setupAutoHeightWithBottomView:self.separaterView bottomMargin:0];
}
- (UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV=[[UIImageView alloc]init];
        //_headerIV.image=[UIImage imageNamed:@"hall_user"];
        [self.contentView addSubview:_headerIV];
        _headerIV.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10)
        .widthIs(24)
        .heightIs(24);
        _headerIV.sd_cornerRadius=@(12);
        
    }
    return _headerIV;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16];
        _nameLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:_nameLab];
        _nameLab.sd_layout
        .leftSpaceToView(self.headerIV, 10)
        .centerYEqualToView(self.headerIV)
        .heightIs(20);
        [_nameLab setSingleLineAutoResizeWithMaxWidth:(kScreenWidth-self.headerIV.right-20)/2];
    }
    return _nameLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _timeLab.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_timeLab];
        _timeLab.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .centerYEqualToView(self.headerIV)
        .heightIs(20);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:(kScreenWidth-self.headerIV.right-20)/2];
    }
    return _timeLab;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:18];
        _titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:_titleLab];
        _titleLab.sd_layout
        .topSpaceToView(self.headerIV, 10)
        .leftSpaceToView(self.contentView, 10)
        .heightIs(15);
        [_titleLab setSingleLineAutoResizeWithMaxWidth:kScreenWidth-20];
    }
    return _titleLab;
}
-(UILabel *)subtitleLab{
    if (!_subtitleLab) {
        _subtitleLab=[[UILabel alloc]init];
        _subtitleLab.font=[UIFont systemFontOfSize:17];
        _subtitleLab.textColor=[UIColor colorWithHexString:@"#898989"];
        _subtitleLab.numberOfLines=2;
        [self.contentView addSubview:_subtitleLab];
        _subtitleLab.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.titleLab, 10)
        .widthIs(kScreenWidth-20)
        .autoHeightRatio(0);
        [_subtitleLab setMaxNumberOfLinesToShow:2];
        
    }
    return _subtitleLab;
}
-(UIImageView *)bigIV{
    if (!_bigIV) {
        _bigIV=[[UIImageView alloc]init];
        //_bigIV.image=[UIImage imageNamed:@""];
        [self.contentView addSubview:_bigIV];
        _bigIV.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.subtitleLab, 10)
        .widthIs(kScreenWidth-20)
        .heightIs(150*kBaseHeight);
    }
    return _bigIV;
}
-(UIImageView *)commentIV{
    if (!_commentIV) {
        _commentIV=[[UIImageView alloc]init];
        //_commentIV.image=[UIImage imageNamed:@"hall_comment"];
        [self.contentView addSubview:_commentIV];
        _commentIV.sd_layout
        .leftEqualToView(self.bigIV)
        .topSpaceToView(self.bigIV, 10)
        .widthIs(10)
        .heightIs(10);
    }
    return _commentIV;
}
-(UILabel *)commentLab{
    if (!_commentLab) {
        _commentLab=[[UILabel alloc]init];
        _commentLab.font=[UIFont systemFontOfSize:10];
        _commentLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_commentLab];
        _commentLab.sd_layout
        .leftSpaceToView(self.commentIV, 5)
        .centerYEqualToView(self.commentIV)
        .heightIs(10);
        [_commentLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _commentLab;
}
-(UIImageView *)praiseIV{
    if (!_praiseIV) {
        _praiseIV=[[UIImageView alloc]init];
        //_praiseIV.image=[UIImage imageNamed:@"hall_snap"];
        [self.contentView addSubview:_praiseIV];
        _praiseIV.sd_layout
        .leftSpaceToView(self.commentLab, 10)
        .centerYEqualToView(self.commentIV)
        .widthIs(10)
        .heightIs(10);
    }
    return _praiseIV;
}
-(UILabel *)praiseLab{
    if (!_praiseLab) {
        _praiseLab=[[UILabel alloc]init];
        _praiseLab.font=[UIFont systemFontOfSize:10];
        _praiseLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_praiseLab];
        _praiseLab.sd_layout
        .leftSpaceToView(self.praiseIV, 5)
        .centerYEqualToView(self.commentIV)
        .heightIs(10);
        [_praiseLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _praiseLab;
}
-(UIView *)separaterView{
    if (!_separaterView) {
        _separaterView=[[UIView alloc]init];
        //_separaterView.backgroundColor=kBackgroundColor;
        [self.contentView addSubview:_separaterView];
        _separaterView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(self.commentIV, 10)
        .heightIs(10);
    }
    return _separaterView;
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
