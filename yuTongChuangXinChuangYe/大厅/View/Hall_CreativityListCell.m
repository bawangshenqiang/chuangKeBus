//
//  Hall_CreativityListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Hall_CreativityListCell.h"

@implementation Hall_CreativityListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.outBig.backgroundColor=[UIColor whiteColor];
//        self.leftIV.image=[UIImage imageNamed:@"picture"];//;[UIImage imageWithColor:[UIColor lightGrayColor]]
//        self.rightLab.text=@"这家公司要用设计+AI创新新时代！这家公司要用设计+AI创新新时代！这家公司要用设计+AI创新新时代！这家公司要用设计+AI创新新时代！";
//
//        [self.flagBtn setTitle:@"新时代" forState:UIControlStateNormal];
    }
    return self;
}
-(void)setModel:(SearchCreativityListModel *)model{
    _model=model;
    self.outBig.backgroundColor=[UIColor whiteColor];
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.rightLab.text=_model.title;
    self.descriptionLab.text=_model.descriptions;
    [self.flagBtn setTitle:_model.category.length?_model.category:@"其他" forState:UIControlStateNormal];
    self.studyLab.text=_model.create_time;
}
-(UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 95)];
        _outBig.layer.cornerRadius=5;
        _outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:_outBig];
    }
    return _outBig;
}
-(UIImageView *)leftIV{
    if (!_leftIV) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 105, 75)];
        [self.outBig addSubview:_leftIV];
    }
    return _leftIV;
}
-(UILabel *)rightLab{
    if (!_rightLab) {
        _rightLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, 10, self.outBig.width-self.leftIV.right-20, 20)];
        
        _rightLab.font=[UIFont boldSystemFontOfSize:16];
        [self.outBig addSubview:_rightLab];
    }
    return _rightLab;
}
-(UILabel *)descriptionLab{
    if (!_descriptionLab) {
        _descriptionLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, self.rightLab.bottom, self.outBig.width-self.leftIV.right-20, 40)];
        _descriptionLab.numberOfLines=1;//2;
        _descriptionLab.font=[UIFont systemFontOfSize:14];
        [self.outBig addSubview:_descriptionLab];
    }
    return _descriptionLab;
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
        .leftSpaceToView(self.leftIV, 10)
        .topSpaceToView(self.descriptionLab, 0);
        [_flagBtn setupAutoSizeWithHorizontalPadding:5 buttonHeight:15];
    }
    return _flagBtn;
}
-(UILabel *)studyLab{
    if (!_studyLab) {
        _studyLab=[[UILabel alloc]init];
        _studyLab.font=[UIFont systemFontOfSize:12];
        _studyLab.textColor=[UIColor lightGrayColor];
        [self.outBig addSubview:_studyLab];
        _studyLab.sd_layout
        .leftSpaceToView(self.flagBtn, 10)
        .topEqualToView(self.flagBtn)
        .heightIs(15);
        [_studyLab setSingleLineAutoResizeWithMaxWidth:150];
    }
    return _studyLab;
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
