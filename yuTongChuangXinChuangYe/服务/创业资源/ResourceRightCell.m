//
//  ResourceRightCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceRightCell.h"

@implementation ResourceRightCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.leftIV.image=[UIImage imageNamed:@"entrepreneurship"];
//        self.titleLab.text=@"宇通服务商名称";
//        self.subTitleLab.text=@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务。";
    }
    return self;
}
-(void)setModel:(ResourceRightModel *)model{
    _model=model;
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"all_nopictures"]];
    self.titleLab.text=_model.title;
    self.subTitleLab.text=_model.descriptions;
}
- (UIImageView *)leftIV{
    if (!_leftIV) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 120, 60)];
        _leftIV.layer.cornerRadius=5;
        _leftIV.layer.borderColor=RGBAColor(145, 165, 165, 0.5).CGColor;
        _leftIV.layer. borderWidth=0.4;
        _leftIV.layer.masksToBounds=YES;
        //_leftIV.image=[UIImage imageNamed:@""];
        [self.contentView addSubview:_leftIV];
    }
    return _leftIV;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, self.leftIV.y, kScreenWidth-65-120-20, 20)];
        _titleLab.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:_titleLab];
    }
    return _titleLab;
}
-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, self.titleLab.bottom, self.titleLab.width, 40)];
        _subTitleLab.numberOfLines=2;
        _subTitleLab.font=[UIFont systemFontOfSize:14];
        _subTitleLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.contentView addSubview:_subTitleLab];
    }
    return _subTitleLab;
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
