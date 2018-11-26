//
//  HuaShanTitleCell_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanTitleCell_HallFirst.h"

@implementation HuaShanTitleCell_HallFirst
/**
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *outBig=[[UIView alloc]init];
        outBig.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:outBig];
        self.outBig=outBig;
        //
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        self.titleLab.numberOfLines=2;
        [outBig addSubview:self.titleLab];
        //
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=RGBAColor(145, 165, 165, 1);
        [outBig addSubview:line];
        self.line=line;
        //
        outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [outBig setupAutoHeightWithBottomView:line bottomMargin:0];
        
        self.titleLab.sd_layout
        .leftSpaceToView(outBig, 10)
        .topSpaceToView(outBig, 8)
        .widthIs(outBig.width-20)
        .autoHeightRatio(0);
        [self.titleLab setMaxNumberOfLinesToShow:2];
        
        line.sd_layout
        .leftEqualToView(self.titleLab)
        .topSpaceToView(self.titleLab, 8)
        .rightEqualToView(self.titleLab)
        .heightIs(0.5);
        
    }
    return self;
}
-(void)setTitleText:(NSString *)titleText{
    _titleText=titleText;
    self.titleLab.text=_titleText;
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:0];
}
*/

-(void)setModel:(HuaShanListModel *)model{
    _model=model;
    self.outBig.backgroundColor=[UIColor whiteColor];
    [self.headerIV sd_setImageWithURL:[NSURL URLWithString:_model.headerUrl] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.name;
    self.timeLab.text=_model.time;
    self.titleLab.text=_model.title;
    self.praiseLab.text=[NSString stringWithFormat:@"%d",_model.praise];
    self.praiseIV.image=[UIImage imageNamed:@"hall_snap"];
    self.commentLab.text=[NSString stringWithFormat:@"%d",_model.comment];
    self.commentIV.image=[UIImage imageNamed:@"hall_comment"];
    [self.outBig setupAutoHeightWithBottomView:self.praiseLab bottomMargin:10];
    self.separaterView.backgroundColor=kBackgroundColor;
    [self setupAutoHeightWithBottomView:self.separaterView bottomMargin:0];
}
-(UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]init];
        //_outBig.backgroundColor=[UIColor whiteColor];
        _outBig.layer.cornerRadius=5;
        [self.contentView addSubview:_outBig];
        _outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [_outBig setupAutoHeightWithBottomView:_praiseLab bottomMargin:10];
    }
    return _outBig;
}
- (UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV=[[UIImageView alloc]init];
        //_headerIV.image=[UIImage imageNamed:@"hall_user"];
        [self.outBig addSubview:_headerIV];
        _headerIV.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.outBig, 10)
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
        _nameLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:_nameLab];
        _nameLab.sd_layout
        .leftSpaceToView(self.headerIV, 10)
        .centerYEqualToView(self.headerIV)
        .heightIs(20);
        [_nameLab setSingleLineAutoResizeWithMaxWidth:(kScreenWidth-20-self.headerIV.right-20)/2];
    }
    return _nameLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _timeLab.textAlignment=NSTextAlignmentRight;
        [self.outBig addSubview:_timeLab];
        _timeLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .centerYEqualToView(self.headerIV)
        .heightIs(20);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:(kScreenWidth-20-self.headerIV.right-20)/2];
    }
    return _timeLab;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:18];
        _titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.outBig addSubview:_titleLab];
        _titleLab.sd_layout
        .topSpaceToView(self.headerIV, 10)
        .leftSpaceToView(self.outBig, 10)
        .widthIs(kScreenWidth-40)
        .autoHeightRatio(0);
        [_titleLab setMaxNumberOfLinesToShow:2];
    }
    return _titleLab;
}
-(UIImageView *)commentIV{
    if (!_commentIV) {
        _commentIV=[[UIImageView alloc]init];
        //_commentIV.image=[UIImage imageNamed:@"hall_comment"];
        [self.outBig addSubview:_commentIV];
        _commentIV.sd_layout
        .rightSpaceToView(self.commentLab, 10)
        .centerYEqualToView(self.commentLab)
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
        [self.outBig addSubview:_commentLab];
        _commentLab.sd_layout
        .rightSpaceToView(self.praiseIV, 5)
        .centerYEqualToView(self.praiseIV)
        .heightIs(10);
        [_commentLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _commentLab;
}
-(UIImageView *)praiseIV{
    if (!_praiseIV) {
        _praiseIV=[[UIImageView alloc]init];
        //_praiseIV.image=[UIImage imageNamed:@"hall_snap"];
        [self.outBig addSubview:_praiseIV];
        _praiseIV.sd_layout
        .rightSpaceToView(self.praiseLab, 10)
        .centerYEqualToView(self.praiseLab)
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
        [self.outBig addSubview:_praiseLab];
        _praiseLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .topSpaceToView(self.titleLab, 10)
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
