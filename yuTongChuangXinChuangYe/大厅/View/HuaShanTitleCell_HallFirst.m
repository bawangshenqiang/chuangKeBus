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
    //self.outBig.backgroundColor=[UIColor whiteColor];
    [self.headerIV sd_setImageWithURL:[NSURL URLWithString:_model.headerUrl] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.name;
    self.timeLab.text=_model.time;
    self.titleLab.text=_model.title;
    self.praiseIV.image=[UIImage imageNamed:@"block_snap"];
    self.praiseLab.text=[NSString stringWithFormat:@"%d",_model.praise];
    self.commentLab.text=[NSString stringWithFormat:@"%d",_model.comment];
    self.commentIV.image=[UIImage imageNamed:@"block_news"];
    //[self.outBig setupAutoHeightWithBottomView:self.praiseLab bottomMargin:10];
    self.separaterView.backgroundColor=RGBAColor(200, 200, 200, 0.5);
    [self setupAutoHeightWithBottomView:self.separaterView bottomMargin:0];
}
//-(UIView *)outBig{
//    if (!_outBig) {
//        _outBig=[[UIView alloc]init];
//        //_outBig.backgroundColor=[UIColor whiteColor];
//        _outBig.layer.cornerRadius=5;
//        [self.contentView addSubview:_outBig];
//        _outBig.sd_layout
//        .leftSpaceToView(self.contentView, 10)
//        .topEqualToView(self.contentView)
//        .widthIs(kScreenWidth-20);
//        [_outBig setupAutoHeightWithBottomView:_praiseLab bottomMargin:10];
//    }
//    return _outBig;
//}
- (UIImageView *)headerIV{
    if (!_headerIV) {
        _headerIV=[[UIImageView alloc]init];
        //_headerIV.image=[UIImage imageNamed:@"hall_user"];
        [self.contentView addSubview:_headerIV];
        _headerIV.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 15)
        .widthIs(30)
        .heightIs(30);
        _headerIV.sd_cornerRadius=@(15);
        
    }
    return _headerIV;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:14];
        _nameLab.textColor=RGBAColor(152, 152, 152, 1);//[UIColor colorWithHexString:@"#989898"];
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
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:_titleLab];
        _titleLab.sd_layout
        .topSpaceToView(self.headerIV, 15)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(kScreenWidth-20)
        .autoHeightRatio(0);
        [_titleLab setMaxNumberOfLinesToShow:2];
    }
    return _titleLab;
}
-(UIImageView *)commentIV{
    if (!_commentIV) {
        _commentIV=[[UIImageView alloc]init];
        //_commentIV.image=[UIImage imageNamed:@"hall_comment"];
        [self.contentView addSubview:_commentIV];
        _commentIV.sd_layout
        .rightSpaceToView(self.commentLab, 8)
        .centerYEqualToView(self.commentLab)
        .widthIs(16)
        .heightIs(16);
    }
    return _commentIV;
}
-(UILabel *)commentLab{
    if (!_commentLab) {
        _commentLab=[[UILabel alloc]init];
        _commentLab.font=[UIFont systemFontOfSize:12];
        _commentLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_commentLab];
        _commentLab.sd_layout
        .rightSpaceToView(self.contentView, 75*kBaseWidth)
        .centerYEqualToView(self.praiseIV)
        .heightIs(16);
        [_commentLab setSingleLineAutoResizeWithMaxWidth:100];
    }
    return _commentLab;
}
-(UIImageView *)praiseIV{
    if (!_praiseIV) {
        _praiseIV=[[UIImageView alloc]init];
        //_praiseIV.image=[UIImage imageNamed:@"hall_snap"];
        [self.contentView addSubview:_praiseIV];
        _praiseIV.sd_layout
        .topSpaceToView(self.titleLab, 20)
        .leftSpaceToView(self.contentView, 75*kBaseWidth)
        .widthIs(16)
        .heightIs(16);
    }
    return _praiseIV;
}
-(UILabel *)praiseLab{
    if (!_praiseLab) {
        _praiseLab=[[UILabel alloc]init];
        _praiseLab.font=[UIFont systemFontOfSize:12];
        _praiseLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_praiseLab];
        _praiseLab.sd_layout
        .leftSpaceToView(self.praiseIV, 8)
        .centerYEqualToView(self.praiseIV)
        .heightIs(16);
        [_praiseLab setSingleLineAutoResizeWithMaxWidth:100];
    }
    return _praiseLab;
}
-(UIView *)separaterView{
    if (!_separaterView) {
        _separaterView=[[UIView alloc]init];
        //_separaterView.backgroundColor=kBackgroundColor;
        [self.contentView addSubview:_separaterView];
        _separaterView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.commentIV, 15)
        .heightIs(0.5);
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
