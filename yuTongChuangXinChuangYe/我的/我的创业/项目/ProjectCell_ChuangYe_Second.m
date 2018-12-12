//
//  ProjectCell_ChuangYe_Second.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectCell_ChuangYe_Second.h"
#import "ProjectCheckModel_ChuangYe.h"

@implementation ProjectCell_ChuangYe_Second
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bigView=[[UIView alloc]init];
        _bigView.backgroundColor=[UIColor whiteColor];
        _bigView.layer.cornerRadius=4;
        _bigView.layer.masksToBounds=YES;
        [self.contentView addSubview:_bigView];
        
        _topIV=[[UIImageView alloc]init];
        [self.bigView addSubview:_topIV];
        
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont boldSystemFontOfSize:16];
        [self.bigView addSubview:_titleLab];
        
        _detailLab=[[UILabel alloc]init];
        _detailLab.font=[UIFont systemFontOfSize:14];
        [self.bigView addSubview:_detailLab];
        
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:_timeLab];
        
        _statusLab=[[UILabel alloc]init];
        _statusLab.font=[UIFont systemFontOfSize:14];
        _statusLab.textAlignment=NSTextAlignmentRight;
        _statusLab.textColor=RGBAColor(0, 92, 175, 1);
        [self.bigView addSubview:_statusLab];
        
        _checkIdeaBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_checkIdeaBut setTitle:@"审核记录" forState:UIControlStateNormal];
        [_checkIdeaBut setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
        _checkIdeaBut.titleLabel.font=[UIFont systemFontOfSize:14];
        _checkIdeaBut.layer.borderColor=RGBAColor(0, 92, 175, 1).CGColor;
        _checkIdeaBut.layer.borderWidth=1;
        _checkIdeaBut.layer.cornerRadius=2;
        [_checkIdeaBut addTarget:self action:@selector(checkIdeaClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:_checkIdeaBut];
        
        _topIV.sd_layout
        .leftEqualToView(self.bigView)
        .rightEqualToView(self.bigView)
        .topEqualToView(self.bigView)
        .heightIs((kScreenWidth-20)*7/11);
        
        _titleLab.sd_layout
        .leftSpaceToView(self.bigView, 12)
        .topSpaceToView(_topIV, 15)
        .widthIs((kScreenWidth-20)-24)
        .autoHeightRatio(0);
        
        _detailLab.sd_layout
        .leftEqualToView(_titleLab)
        .topSpaceToView(_titleLab, 12)
        .widthRatioToView(_titleLab, 1)
        .autoHeightRatio(0);
        
        _timeLab.sd_layout
        .leftEqualToView(_titleLab)
        .topSpaceToView(_detailLab, 20)
        .widthRatioToView(_titleLab, 0.5)
        .autoHeightRatio(0);
        
        _statusLab.sd_layout
        .rightEqualToView(_titleLab)
        .centerYEqualToView(_timeLab)
        .widthRatioToView(_titleLab, 0.5)
        .autoHeightRatio(0);
        
        _checkIdeaBut.sd_layout
        .leftSpaceToView(_bigView, 12)
        .topSpaceToView(_timeLab, 20)
        .widthIs(80)
        .heightIs(24);
        
        self.bigView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10);
        [self.bigView setupAutoHeightWithBottomView:_checkIdeaBut bottomMargin:20];
        
        //
        self.aView=[[ThreeAuditView alloc]initWithFrame:CGRectMake(0, (kScreenWidth-20)*7/11-60, kScreenWidth-20, 60)];
        
        [_topIV addSubview:self.aView];
    }
    return self;
}
-(void)setModel:(ProjectModel_ChuangYe *)model{
    _model=model;
    
    [self.topIV sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.titleLab.text=_model.title;
    self.detailLab.text=_model.descriptions;
    self.timeLab.text=_model.times;
    self.statusLab.text=_model.status;
    
    ProjectCheckModel_ChuangYe *model1=_model.checkModels.firstObject;
    ProjectCheckModel_ChuangYe *model2=_model.checkModels[1];
    ProjectCheckModel_ChuangYe *model3=_model.checkModels.lastObject;
    
    if (model1.state==0) {
        [self.aView resetCircleFrameAndLineColor:1];
    }else if (model1.state==1){
        if (model2.state==0) {
            [self.aView resetCircleFrameAndLineColor:3];
        }else if (model2.state==1){
            if (model3.state==0) {
                [self.aView resetCircleFrameAndLineColor:5];
            }else if (model3.state==1){
                [self.aView resetCircleFrameAndLineColor:7];
            }else if (model3.state==2){
                [self.aView resetCircleFrameAndLineColor:6];
            }
        }else if (model2.state==2){
            [self.aView resetCircleFrameAndLineColor:4];
        }
    }else if (model1.state==2){
        [self.aView resetCircleFrameAndLineColor:2];
    }
    
    self.aView.firstTitle.text=model1.status;
    self.aView.secondTitle.text=model2.status;
    self.aView.thirdTitle.text=model3.status;
    
    [self setupAutoHeightWithBottomView:self.bigView bottomMargin:0];
}
-(void)checkIdeaClick{
    if (self.checkIdeaBlock) {
        self.checkIdeaBlock(_model);
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
