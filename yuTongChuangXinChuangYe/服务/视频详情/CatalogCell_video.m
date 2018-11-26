//
//  CatalogCell_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CatalogCell_video.h"

@implementation CatalogCell_video
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftIV.image=[UIImage imageNamed:@"directory_broadcast"];
    }
    return self;
}
-(void)setModel:(CatalogModel_video *)model{
    _model=model;
    self.detailLab.text=_model.detail;
    self.timeLab.text=_model.create_time;
    self.line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
}
-(UIImageView *)leftIV{
    if (!_leftIV) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
        [self.contentView addSubview:_leftIV];
    }
    return _leftIV;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right, 15, 80, 15)];
        _titleLab.font=[UIFont boldSystemFontOfSize:17];
        _titleLab.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
//        _titleLab.sd_layout
//        .leftSpaceToView(self.leftIV, 15)
//        .topEqualToView(self.leftIV)
//        .heightIs(15);
//        [_titleLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _titleLab;
}
-(UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab=[[UILabel alloc]init];
        _detailLab.font=[UIFont systemFontOfSize:16];
        _detailLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:_detailLab];
        _detailLab.sd_layout
        .leftSpaceToView(self.titleLab, 0)
        .topEqualToView(self.titleLab)
        .heightIs(15);
        [_detailLab setSingleLineAutoResizeWithMaxWidth:kScreenWidth-105-80];
    }
    return _detailLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.textAlignment=NSTextAlignmentRight;
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_timeLab];
        _timeLab.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .topEqualToView(self.titleLab)
        .widthIs(70)
        .heightIs(15);
    }
    return _timeLab;
}
-(UIView *)line{
    if (!_line) {
        _line=[[UIView alloc]initWithFrame:CGRectMake(10, self.leftIV.bottom+14.5, kScreenWidth-20, 0.5)];
        
        [self.contentView addSubview:_line];
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
