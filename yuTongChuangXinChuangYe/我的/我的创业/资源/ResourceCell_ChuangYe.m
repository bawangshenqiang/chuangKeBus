//
//  ResourceCell_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceCell_ChuangYe.h"

@implementation ResourceCell_ChuangYe
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig.backgroundColor=[UIColor whiteColor];
//        self.leftIV.image=[UIImage imageNamed:@"entrepreneurship"];
//        self.topLab.text=@"这家公司要用设计+AI创新新时代！这家公司要用设计+AI创新新时代！";
//        self.bottomLab.text=@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务。";
//        self.separatorLine.backgroundColor=RGBAColor(145, 165, 165, 0.5);
//        self.needExplain.text=@"需求说明：为查看您的需求，请耐心等待为查看您的需求，请耐心等待为查看您的需求，请耐心等待";
//        
    }
    return self;
}
-(void)setModel:(ResourceModel_ChuangYe *)model{
    _model=model;
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"entrepreneurship"]];
    self.topLab.text=_model.title;
    self.bottomLab.text=_model.descriptions;
    self.separatorLine.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    self.needExplain.text=_model.demand;
}
-(UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 130)];
        _outBig.layer.cornerRadius=5;
        _outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:_outBig];
    }
    return _outBig;
}
-(UIImageView *)leftIV{
    if (!_leftIV) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 130, 60)];
        [self.outBig addSubview:_leftIV];
    }
    return _leftIV;
}
-(UILabel *)topLab{
    if (!_topLab) {
        _topLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, 10, self.outBig.width-self.leftIV.right-20, 20)];
        //_topLab.numberOfLines=3;
        _topLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_topLab];
    }
    return _topLab;
}
-(UILabel *)bottomLab{
    if (!_bottomLab) {
        _bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, self.topLab.bottom, self.topLab.width, 40)];
        _bottomLab.numberOfLines=2;
        _bottomLab.font=[UIFont systemFontOfSize:14];
        _bottomLab.textColor=[UIColor lightGrayColor];
        [self.outBig addSubview:_bottomLab];
    }
    return _bottomLab;
}
-(UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine=[[UIView alloc]init];
        _separatorLine.backgroundColor=RGBAColor(145, 165, 165, 0.5);
        [self.outBig addSubview:_separatorLine];
        _separatorLine.sd_layout
        .leftEqualToView(self.leftIV)
        .rightEqualToView(self.topLab)
        .topSpaceToView(self.leftIV, 9.5)
        .heightIs(0.5);
    }
    return _separatorLine;
}
-(UILabel *)needExplain{
    if (!_needExplain) {
        _needExplain=[[UILabel alloc]init];
        _needExplain.numberOfLines=2;
        _needExplain.font=[UIFont systemFontOfSize:14];
        [self.outBig addSubview:_needExplain];
        _needExplain.sd_layout
        .leftEqualToView(self.leftIV)
        .topSpaceToView(self.separatorLine, 5)
        .rightEqualToView(self.topLab)
        .heightIs(40);
    }
    return _needExplain;
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
