//
//  ProjectAuditCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectAuditCell.h"

@implementation ProjectAuditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.bigView=[[UIView alloc]init];
        self.bigView.backgroundColor=[UIColor whiteColor];
        self.bigView.layer.cornerRadius=4;
        self.bigView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.bigView];
        //
        self.title=[[UILabel alloc]init];
        self.title.font=[UIFont boldSystemFontOfSize:14];
        self.title.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.title];
        //
        self.times=[[UILabel alloc]init];
        self.times.font=[UIFont systemFontOfSize:12];
        self.times.textColor=RGBAColor(102, 102, 102, 1);
        self.times.textAlignment=NSTextAlignmentRight;
        [self.bigView addSubview:self.times];
        //
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=RGBAColor(165, 165, 165, 0.5);
        [self.bigView addSubview:line];
        //
        self.statusLab=[[UILabel alloc]init];
        self.statusLab.text=@"审核状态";
        self.statusLab.font=[UIFont systemFontOfSize:14];
        self.statusLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:self.statusLab];
        //
        self.firstAuditStatus=[[UILabel alloc]init];
        //self.firstAuditStatus.text=@"一审";
        self.firstAuditStatus.font=[UIFont systemFontOfSize:14];
        self.firstAuditStatus.textColor=[UIColor whiteColor];
        self.firstAuditStatus.textAlignment=NSTextAlignmentCenter;
        self.firstAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
        [self.bigView addSubview:self.firstAuditStatus];
        //
        self.secondAuditStatus=[[UILabel alloc]init];
        //self.secondAuditStatus.text=@"二审";
        self.secondAuditStatus.font=[UIFont systemFontOfSize:14];
        self.secondAuditStatus.textColor=[UIColor whiteColor];
        self.secondAuditStatus.textAlignment=NSTextAlignmentCenter;
        self.secondAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
        [self.bigView addSubview:self.secondAuditStatus];
        //
        self.thirdAuditStatus=[[UILabel alloc]init];
        //self.thirdAuditStatus.text=@"三审";
        self.thirdAuditStatus.font=[UIFont systemFontOfSize:14];
        self.thirdAuditStatus.textColor=[UIColor whiteColor];
        self.thirdAuditStatus.textAlignment=NSTextAlignmentCenter;
        self.thirdAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
        [self.bigView addSubview:self.thirdAuditStatus];
        //
        self.sugmentLab=[[UILabel alloc]init];
        self.sugmentLab.text=@"审核意见";
        self.sugmentLab.font=[UIFont systemFontOfSize:14];
        self.sugmentLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:self.sugmentLab];
        //
        self.segmentView=[[AuditSegmentView alloc]init];
        [self.bigView addSubview:self.segmentView];
        //
        self.accessoryLoad=[[UILabel alloc]init];
        self.accessoryLoad.text=@"附件下载";
        self.accessoryLoad.font=[UIFont systemFontOfSize:14];
        self.accessoryLoad.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:self.accessoryLoad];
        //
        self.accessoryName=[[AccessoryNameView alloc]init];
        [self.bigView addSubview:self.accessoryName];
        
        //
        self.title.sd_layout
        .leftSpaceToView(self.bigView, 12)
        .topSpaceToView(self.bigView, 18)
        .heightIs(15);
        [self.title setSingleLineAutoResizeWithMaxWidth:kScreenWidth-20-24-60];
        //
        self.times.sd_layout
        .rightSpaceToView(self.bigView, 12)
        .centerYEqualToView(self.title)
        .widthIs(60)
        .heightIs(15);
        //
        line.sd_layout
        .leftEqualToView(self.bigView)
        .rightEqualToView(self.bigView)
        .topSpaceToView(self.title, 15)
        .heightIs(0.5);
        //
        self.statusLab.sd_layout
        .leftSpaceToView(self.bigView, 12)
        .topSpaceToView(line, 15)
        .heightIs(15);
        [self.statusLab setSingleLineAutoResizeWithMaxWidth:80];
        //
        self.firstAuditStatus.sd_layout
        .leftSpaceToView(self.statusLab, 20)
        .topSpaceToView(line, 10)
        .widthIs(70)
        .heightIs(24);
        self.firstAuditStatus.sd_cornerRadius=@(12);
        //
        self.secondAuditStatus.sd_layout
        .leftSpaceToView(self.firstAuditStatus, 15)
        .topEqualToView(self.firstAuditStatus)
        .widthIs(70)
        .heightIs(24);
        self.secondAuditStatus.sd_cornerRadius=@(12);
        //
        self.thirdAuditStatus.sd_layout
        .leftSpaceToView(self.secondAuditStatus, 15)
        .topEqualToView(self.firstAuditStatus)
        .widthIs(70)
        .heightIs(24);
        self.thirdAuditStatus.sd_cornerRadius=@(12);
        //
        self.sugmentLab.sd_layout
        .leftEqualToView(self.statusLab)
        .topSpaceToView(self.statusLab, 24)
        .heightIs(15);
        [self.sugmentLab setSingleLineAutoResizeWithMaxWidth:80];
        //
        self.segmentView.sd_layout
        .leftSpaceToView(self.sugmentLab, 20)
        .topSpaceToView(self.firstAuditStatus, 15)
        .widthIs(kScreenWidth-20-self.sugmentLab.right-20-12);
        
        //
        self.accessoryLoad.sd_layout
        .leftEqualToView(self.statusLab)
        .topSpaceToView(self.segmentView, 20)
        .heightIs(15);
        [self.accessoryLoad setSingleLineAutoResizeWithMaxWidth:80];
        //
        self.accessoryName.sd_layout
        .leftSpaceToView(self.accessoryLoad, 20)
        .topEqualToView(self.accessoryLoad)
        .widthIs(kScreenWidth-20-self.sugmentLab.right-20-12);
        
        //
        self.bigView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 15)
        .widthIs(kScreenWidth-20);
        [self.bigView setupAutoHeightWithBottomViewsArray:@[self.segmentView,self.accessoryName] bottomMargin:30];
    }
    return self;
}
-(void)setModel:(ProjectModel_ChuangYe *)model{
    _model=model;
    self.title.text=_model.title;
    self.times.text=_model.times;
    ProjectCheckModel_ChuangYe *model1=_model.checkModels.firstObject;
    ProjectCheckModel_ChuangYe *model2=_model.checkModels[1];
    ProjectCheckModel_ChuangYe *model3=_model.checkModels.lastObject;
    self.firstAuditStatus.text=model1.status;
    self.secondAuditStatus.text=model2.status;
    self.thirdAuditStatus.text=model3.status;
    if (model1.state==1) {
        self.firstAuditStatus.backgroundColor=RGBAColor(126, 226, 0, 1);
    }else if (model1.state==2){
        self.firstAuditStatus.backgroundColor=RGBAColor(240, 17, 0, 1);
    }else{
        self.firstAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
    }
    if (model2.state==1) {
        self.secondAuditStatus.backgroundColor=RGBAColor(126, 226, 0, 1);
    }else if (model2.state==2){
        self.secondAuditStatus.backgroundColor=RGBAColor(240, 17, 0, 1);
    }else{
        self.secondAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
    }
    if (model3.state==1) {
        self.thirdAuditStatus.backgroundColor=RGBAColor(126, 226, 0, 1);
    }else if (model3.state==2){
        self.thirdAuditStatus.backgroundColor=RGBAColor(240, 17, 0, 1);
    }else{
        self.thirdAuditStatus.backgroundColor=RGBAColor(153, 153, 153, 1);
    }
    self.segmentView.array=_model.checkModels;
    if (model1.suggestionfile.length>0||model2.suggestionfile.length>0||model3.suggestionfile.length>0) {
        self.accessoryLoad.hidden=NO;
        self.accessoryName.array=_model.checkModels;
        [self.bigView setupAutoHeightWithBottomView:self.accessoryName bottomMargin:30];
    }else{
        self.accessoryLoad.hidden=YES;
        [self.bigView setupAutoHeightWithBottomView:self.segmentView bottomMargin:30];
    }
    
    
    [self setupAutoHeightWithBottomView:self.bigView bottomMargin:0];
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
