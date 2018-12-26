//
//  CaredNumberListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CaredNumberListCell.h"

@implementation CaredNumberListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 40, 40)];
        self.leftIV.layer.cornerRadius=20;
        self.leftIV.layer.masksToBounds=YES;
        [self.contentView addSubview:self.leftIV];
        //
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+12, 15, (kScreenWidth-36-40)/2, 14)];
        self.nameLab.font=[UIFont systemFontOfSize:14];
        self.nameLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:self.nameLab];
        //
        self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLab.right, 15, (kScreenWidth-36-40)/2, 14)];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        self.timeLab.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLab];
        //
        self.telephoneLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+12, self.nameLab.bottom+12, 100, 14)];
        self.telephoneLab.font=[UIFont systemFontOfSize:14];
        self.telephoneLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.telephoneLab];
        //
        self.teleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.teleBtn.frame=CGRectMake(self.telephoneLab.right+10, self.nameLab.bottom+11, 16, 16);
        [self.teleBtn setImage:[UIImage imageNamed:@"demand_telephone"] forState:UIControlStateNormal];
        [self.teleBtn addTarget:self action:@selector(teleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.teleBtn];
        //
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(12, self.leftIV.bottom+15, kScreenWidth-24, 0.5)];
        line.backgroundColor=RGBAColor(200, 200, 200, 1);
        [self.contentView addSubview:line];
        //
        UIImageView *firstIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, line.bottom+20, 15, 16)];
        firstIV.image=[UIImage imageNamed:@"e-commerce_position"];
        [self.contentView addSubview:firstIV];
        //
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(firstIV.right+12, line.bottom+20, 100, 16)];
        lab1.text=@"期望职位";
        lab1.font=[UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:lab1];
        //
        self.position=[[UILabel alloc]initWithFrame:CGRectMake(39, lab1.bottom+20, kScreenWidth-39-12, 14)];
        self.position.font=[UIFont systemFontOfSize:14];
        self.position.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.position];
        //
        UIImageView *secondIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, self.position.bottom+20, 13, 15)];
        secondIV.image=[UIImage imageNamed:@"e-commerce_personal"];
        [self.contentView addSubview:secondIV];
        //
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(secondIV.right+14, self.position.bottom+20, 100, 15)];
        lab2.text=@"个人简介";
        lab2.font=[UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:lab2];
        //
        self.userinfo=[[UILabel alloc]init];
        self.userinfo.font=[UIFont systemFontOfSize:14];
        self.userinfo.textColor=RGBAColor(51, 51, 51, 1);
        self.userinfo.numberOfLines=0;
        [self.contentView addSubview:self.userinfo];
        self.userinfo.sd_layout
        .leftSpaceToView(self.contentView, 39)
        .topSpaceToView(lab2, 18)
        .rightSpaceToView(self.contentView, 12)
        .autoHeightRatio(0);
        [self.userinfo setMaxNumberOfLinesToShow:3];
        //
        self.allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [self.allBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [self.allBtn setTitle:@"收起" forState:UIControlStateSelected];
        [self.allBtn setTitleColor:kThemeColor forState:UIControlStateSelected];
        self.allBtn.selected=NO;
        self.allBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.allBtn];
        //
        self.allBtn.sd_layout
        .rightEqualToView(self.userinfo)
        .topSpaceToView(self.userinfo, 5);
        [self.allBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    }
    return self;
}
-(void)allBtnClick{
    
    _model.showAll=!_model.showAll;
    
    if (self.lookAllBtnBlock) {
        self.lookAllBtnBlock(_indexPath);
    }
}
-(void)setModel:(CaredNumberListModel *)model{
    _model=model;
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.photo]];
    self.nameLab.text=_model.linker;
    self.telephoneLab.text=_model.linkphone;
    self.timeLab.text=_model.create_time;
    self.position.text=_model.job;
    self.userinfo.text=_model.descriptions;
    if (_model.showAll) {
        self.allBtn.selected=YES;
        self.userinfo.sd_resetLayout
        .leftSpaceToView(self.contentView, 39)
        .topSpaceToView(self.position, 53)
        .rightSpaceToView(self.contentView, 12)
        .autoHeightRatio(0);
        [self.userinfo setMaxNumberOfLinesToShow:0];
    }else{
        self.allBtn.selected=NO;
        self.userinfo.sd_resetLayout
        .leftSpaceToView(self.contentView, 39)
        .topSpaceToView(self.position, 53)
        .rightSpaceToView(self.contentView, 12)
        .autoHeightRatio(0);
        [self.userinfo setMaxNumberOfLinesToShow:3];
    }
    
    [self setupAutoHeightWithBottomView:self.allBtn bottomMargin:10];
}
-(void)teleBtnClick{
    if (self.teleBtnBlock) {
        self.teleBtnBlock(_model.linkphone);
    }
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
