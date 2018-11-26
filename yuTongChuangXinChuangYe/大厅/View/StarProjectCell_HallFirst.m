//
//  StarProjectCell_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "StarProjectCell_HallFirst.h"

@implementation StarProjectCell_HallFirst
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
-(void)setModel_starProject:(Hall_HomeStarProject *)model_starProject{
    _model_starProject=model_starProject;
    self.outBig.backgroundColor=[UIColor whiteColor];
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model_starProject.cover] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.rightLab.text=_model_starProject.title;
    [self.flagBtn setTitle:_model_starProject.category forState:UIControlStateNormal];
}
-(void)setModel_video:(CourseModel_video *)model_video{
    _model_video=model_video;
    self.outBig.backgroundColor=[UIColor whiteColor];
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model_video.imageUrl] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.rightLab.text=_model_video.title;
    [self.flagBtn setTitle:_model_video.flag forState:UIControlStateNormal];
    self.studyLab.text=[NSString stringWithFormat:@"%d人学过",_model_video.peopleCount];
}
-(void)setModel_serve:(StarCourseModel_Serve *)model_serve{
    _model_serve=model_serve;
    self.outBig.backgroundColor=[UIColor whiteColor];
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model_serve.picture] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.rightLab.text=_model_serve.title;
    [self.flagBtn setTitle:_model_serve.label forState:UIControlStateNormal];
    self.studyLab.text=[NSString stringWithFormat:@"%d人学过",_model_serve.views];
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
        _rightLab=[[UILabel alloc]init];//WithFrame:CGRectMake(self.leftIV.right+10, 10, self.outBig.width-self.leftIV.right-20, 60)
        _rightLab.numberOfLines=3;
        _rightLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_rightLab];
        _rightLab.sd_layout
        .leftSpaceToView(self.leftIV, 10)
        .topSpaceToView(self.outBig, 10)
        .widthIs(self.outBig.width-self.leftIV.right-20)
        .autoHeightRatio(0);
    }
    return _rightLab;
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
        .topSpaceToView(self.outBig, 70);
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
