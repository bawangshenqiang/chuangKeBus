//
//  PolicyListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PolicyListCell.h"

@implementation PolicyListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)setModel:(InformationListModel *)model{
    _model=model;
    self.leftLab.text=_model.title;
    [self.flagBtn setTitle:_model.label forState:UIControlStateNormal];
    self.fromLab.text=_model.source;
    self.timeLab.text=_model.create_time;
}
-(UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 90)];
        _outBig.layer.cornerRadius=5;
        _outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:_outBig];
    }
    return _outBig;
}

-(UILabel *)leftLab{
    if (!_leftLab) {
        _leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.outBig.width-20, 40)];
        _leftLab.numberOfLines=2;
        _leftLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_leftLab];
    }
    return _leftLab;
}

-(UIButton *)flagBtn{
    if (!_flagBtn) {
        _flagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_flagBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        _flagBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _flagBtn.layer.borderColor=kThemeColor.CGColor;
        _flagBtn.layer.borderWidth=0.5;
        [self.outBig addSubview:_flagBtn];
        
        _flagBtn.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.leftLab, 10);
        [_flagBtn setupAutoSizeWithHorizontalPadding:5 buttonHeight:15];
    }
    return _flagBtn;
}
-(UILabel *)fromLab{
    if (!_fromLab) {
        _fromLab=[[UILabel alloc]init];
        _fromLab.font=[UIFont systemFontOfSize:12];
        _fromLab.textColor=[UIColor lightGrayColor];
        [self.outBig addSubview:_fromLab];
        _fromLab.sd_layout
        .leftSpaceToView(self.flagBtn, 10)
        .topEqualToView(self.flagBtn)
        .heightIs(15);
        [_fromLab setSingleLineAutoResizeWithMaxWidth:150];
    }
    return _fromLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=[UIColor lightGrayColor];
        [self.outBig addSubview:_timeLab];
        _timeLab.sd_layout
        .leftSpaceToView(self.fromLab, 10)
        .topEqualToView(self.flagBtn)
        .heightIs(15);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:150];
    }
    return _timeLab;
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
