//
//  HotServeSecondCell_ServeFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HotServeSecondCell_ServeFirst.h"

@implementation HotServeSecondCell_ServeFirst

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.outBig.backgroundColor=[UIColor whiteColor];
//        self.leftIV.image=[UIImage imageNamed:@"entrepreneurship"];
//        self.topLab.text=@"这家公司要用设计+AI创新新时代！这家公司要用设计+AI创新新时代！";
//        self.bottomLab.text=@"用终局思维看待AI时代，也就是“万物有生”的时代，其本质即服务。";
    }
    return self;
}
-(void)setModel:(StarCourseModel_Serve *)model{
    _model=model;
    self.outBig.backgroundColor=[UIColor whiteColor];
    self.leftIV.frame=CGRectMake(10, 10, 120, 60);
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.picture] placeholderImage:[UIImage imageNamed:@"entrepreneurship"]];
    self.topLab.text=_model.title;
    self.bottomLab.text=_model.descripetions;
}
-(void)setHallModel:(Hall_HomeTodayHotModel *)hallModel{
    _hallModel=hallModel;
    self.outBig.backgroundColor=[UIColor whiteColor];
    self.leftIV.frame=CGRectMake(10, 5, 110, 70);
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_hallModel.cover] placeholderImage:[UIImage imageNamed:@"entrepreneurship"]];
    self.topLab.text=_hallModel.title;
    self.bottomLab.text=_hallModel.descriptions;
}
-(UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 80)];
        _outBig.layer.cornerRadius=5;
        _outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:_outBig];
    }
    return _outBig;
}
-(UIImageView *)leftIV{
    if (!_leftIV) {
        _leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 60)];
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
