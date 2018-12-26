//
//  TeamCell_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TeamCell_ChuangYe.h"

@implementation TeamCell_ChuangYe
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.outBig.layer.cornerRadius=5;
        self.outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:self.outBig];
        //
        self.title=[UIButton buttonWithType:UIButtonTypeCustom];
        self.title.frame=CGRectMake(12, 20, kScreenWidth-20-24-10, 14);
        self.title.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        self.title.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.title setTitleColor:RGBAColor(51, 51, 51, 1) forState:UIControlStateNormal];
        [self.title addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
        [self.outBig addSubview:self.title];
        //
        self.flagIV=[[UIImageView alloc]initWithFrame:CGRectMake(self.title.right, 20, 10, 16)];
        self.flagIV.image=[UIImage imageNamed:@"team_arrow"];
        [self.outBig addSubview:self.flagIV];
        //
        self.statusLab=[[UILabel alloc]init];
        self.statusLab.text=@"审核状态:";
        self.statusLab.font=[UIFont systemFontOfSize:14];
        self.statusLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.outBig addSubview:self.statusLab];
        //
        self.status=[[UILabel alloc]init];
        self.status.font=[UIFont systemFontOfSize:14];
        self.status.textColor=RGBAColor(0, 92, 175, 1);
        [self.outBig addSubview:self.status];
        //
        self.checkIdeaLab=[[UILabel alloc]init];
        self.checkIdeaLab.text=@"审核意见:";
        self.checkIdeaLab.font=[UIFont systemFontOfSize:14];
        self.checkIdeaLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.outBig addSubview:self.checkIdeaLab];
        //
        self.checkIdea=[[UILabel alloc]init];
        self.checkIdea.font=[UIFont systemFontOfSize:14];
        self.checkIdea.textColor=RGBAColor(51, 51, 51, 1);
        self.checkIdea.numberOfLines=0;
        [self.outBig addSubview:self.checkIdea];
        //
        self.careLab=[[UILabel alloc]init];
        self.careLab.font=[UIFont systemFontOfSize:12];
        self.careLab.textColor=RGBAColor(255, 150, 0, 1);
        [self.outBig addSubview:self.careLab];
        //
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.font=[UIFont systemFontOfSize:12];
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.outBig addSubview:self.timeLab];
        //
        self.lookLab=[[UILabel alloc]init];
        self.lookLab.text=@"查看名单 >>";
        self.lookLab.font=[UIFont systemFontOfSize:14];
        self.lookLab.textColor=RGBAColor(0, 92, 175, 1);
        [self.outBig addSubview:self.lookLab];
        //
        self.statusLab.sd_layout
        .leftSpaceToView(self.outBig, 12)
        .topSpaceToView(self.title, 15)
        .heightIs(14);
        [self.statusLab setSingleLineAutoResizeWithMaxWidth:100];
        self.status.sd_layout
        .leftSpaceToView(self.statusLab, 5)
        .topEqualToView(self.statusLab)
        .heightIs(14)
        .widthIs(100);
        self.checkIdeaLab.sd_layout
        .leftSpaceToView(self.outBig, 12)
        .topSpaceToView(self.statusLab, 20)
        .heightIs(14);
        [self.checkIdeaLab setSingleLineAutoResizeWithMaxWidth:100];
        self.checkIdea.sd_layout
        .topEqualToView(self.checkIdeaLab)
        .leftSpaceToView(self.checkIdeaLab, 5)
        .rightSpaceToView(self.outBig, 12)
        .autoHeightRatio(0);
        //
        self.careLab.sd_layout
        .leftEqualToView(self.statusLab)
        .topSpaceToView(self.checkIdea, 20)
        .widthIs((kScreenWidth-20-24)/2)
        .autoHeightRatio(0);
        self.timeLab.sd_layout
        .rightSpaceToView(self.outBig, 12)
        .topEqualToView(self.careLab)
        .widthIs((kScreenWidth-20-24)/2)
        .autoHeightRatio(0);
        self.lookLab.sd_layout
        .leftEqualToView(self.statusLab)
        .topSpaceToView(self.careLab, 20)
        .heightIs(14);
        [self.lookLab setSingleLineAutoResizeWithMaxWidth:120];
        //
        self.outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10);
        [self.outBig setupAutoHeightWithBottomViewsArray:@[self.timeLab,self.lookLab] bottomMargin:20];
    }
    return self;
}
-(void)titleClick{
    if (self.titleClickBlock) {
        self.titleClickBlock(_model);
    }
}
-(void)setModel:(TeamModel_ChuangYe *)model{
    _model=model;
    if (_model.state==0||_model.state==3) {
        //审核中
        [self.title setTitle:_model.title forState:UIControlStateNormal];
        self.status.text=_model.status;
        self.status.textColor=RGBAColor(255, 150, 0, 1);
        self.checkIdeaLab.hidden=YES;
        self.checkIdea.hidden=YES;
        self.careLab.hidden=YES;
        self.timeLab.text=_model.create_time;
        self.lookLab.hidden=YES;
        self.timeLab.sd_resetLayout
        .rightSpaceToView(self.outBig, 12)
        .topSpaceToView(self.status, 20)
        .widthIs((kScreenWidth-20-24)/2)
        .autoHeightRatio(0);
        [self.outBig setupAutoHeightWithBottomView:self.timeLab bottomMargin:20];
    }else if (_model.state==2){
        //未通过
        [self.title setTitle:_model.title forState:UIControlStateNormal];
        self.status.text=_model.status;
        self.status.textColor=RGBAColor(255, 0, 0, 1);
        self.checkIdeaLab.hidden=NO;
        self.checkIdea.hidden=NO;
        self.checkIdea.text=_model.note;
        self.careLab.hidden=YES;
        self.timeLab.text=_model.create_time;
        self.lookLab.hidden=YES;
        self.timeLab.sd_resetLayout
        .rightSpaceToView(self.outBig, 12)
        .topSpaceToView(self.checkIdea, 20)
        .widthIs((kScreenWidth-20-24)/2)
        .autoHeightRatio(0);
        [self.outBig setupAutoHeightWithBottomView:self.timeLab bottomMargin:20];
    }else if (_model.state==1){
        //已通过
        [self.title setTitle:_model.title forState:UIControlStateNormal];
        self.status.text=_model.status;
        self.status.textColor=RGBAColor(0, 92, 175, 1);
        self.checkIdeaLab.hidden=NO;
        self.checkIdea.hidden=NO;
        self.checkIdea.text=_model.note;
        self.careLab.hidden=NO;
        self.careLab.text=[NSString stringWithFormat:@"已有%d人感兴趣",_model.talks];
        self.timeLab.text=_model.create_time;
        self.lookLab.hidden=NO;
        self.timeLab.sd_resetLayout
        .rightSpaceToView(self.outBig, 12)
        .topEqualToView(self.careLab)
        .widthIs((kScreenWidth-20-24)/2)
        .autoHeightRatio(0);
        [self.outBig setupAutoHeightWithBottomView:self.lookLab bottomMargin:20];
    }
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
