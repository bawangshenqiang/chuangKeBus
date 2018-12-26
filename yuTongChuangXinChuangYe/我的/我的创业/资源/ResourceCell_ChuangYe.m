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
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.outBig.layer.cornerRadius=4;
        self.outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:self.outBig];
        //
        self.leftIV=[[UIImageView alloc]init];
        self.leftIV.image=[UIImage imageNamed:@"entrepreneurship_user"];
        [self.outBig addSubview:self.leftIV];
        //
        self.nameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.nameBtn setTitleColor:RGBAColor(102, 102, 102, 1) forState:UIControlStateNormal];
        self.nameBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        self.nameBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [self.nameBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.outBig addSubview:self.nameBtn];
        //
        self.statusLab=[[UILabel alloc]init];
        self.statusLab.font=[UIFont systemFontOfSize:13];
        self.statusLab.textAlignment=NSTextAlignmentRight;
        self.statusLab.textColor=RGBAColor(255, 150, 0, 1);
        [self.outBig addSubview:self.statusLab];
        //
        self.needExplain=[[UILabel alloc]init];
        self.needExplain.numberOfLines=3;
        self.needExplain.font=[UIFont systemFontOfSize:15];
        self.needExplain.textColor=RGBAColor(65, 65, 65, 1);
        [self.outBig addSubview:self.needExplain];
        //
        self.progressLab=[[UILabel alloc]init];
        self.progressLab.font=[UIFont systemFontOfSize:15];
        self.progressLab.textColor=RGBAColor(0, 92, 175, 1);
        [self.outBig addSubview:self.progressLab];
        //
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.font=[UIFont systemFontOfSize:13];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.outBig addSubview:self.timeLab];
        //
        self.leftIV.sd_layout
        .leftSpaceToView(self.outBig, 15)
        .topSpaceToView(self.outBig, 15)
        .widthIs(30)
        .heightIs(30);
        self.leftIV.sd_cornerRadius=@(15);
        //
        self.nameBtn.sd_layout
        .leftSpaceToView(self.leftIV, 15)
        .topEqualToView(self.leftIV);
        [self.nameBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:30];
        //
        self.statusLab.sd_layout
        .rightSpaceToView(self.outBig, 15)
        .topEqualToView(self.nameBtn)
        .widthIs(70)
        .heightIs(30);
        //
        self.needExplain.sd_layout
        .topSpaceToView(self.nameBtn, 15)
        .leftEqualToView(self.nameBtn)
        .widthIs(kScreenWidth-24-60-15)
        .autoHeightRatio(0);
        [self.needExplain setMaxNumberOfLinesToShow:3];
        //
        self.progressLab.sd_layout
        .leftEqualToView(self.nameBtn)
        .topSpaceToView(self.needExplain, 15)
        .widthIs(kScreenWidth-24-60-85)
        .heightIs(30);
        //
        self.timeLab.sd_layout
        .rightSpaceToView(self.outBig, 15)
        .topEqualToView(self.progressLab)
        .widthIs(70)
        .heightIs(30);
        //
        self.outBig.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .widthIs(kScreenWidth-24);
        [self.outBig setupAutoHeightWithBottomView:self.progressLab bottomMargin:10];
        
        
    }
    return self;
}
-(void)btnClick{
    if (self.btnClickBlock) {
        self.btnClickBlock(_model.providerId);
    }
}
-(void)setModel:(ResourceModel_ChuangYe_second *)model{
    _model=model;
    //[self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:nil];
    [self.nameBtn setTitle:[NSString stringWithFormat:@"%@ >",_model.title] forState:UIControlStateNormal];
    self.statusLab.text=_model.pstatus;
    self.needExplain.text=_model.demand;
    self.progressLab.text=@"查看服务进度 >>";
    self.timeLab.text=_model.create_time;
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:0];
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
