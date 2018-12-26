//
//  ClientDemandListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ClientDemandListCell.h"

@implementation ClientDemandListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bigView=[[UIView alloc]init];
        self.bigView.backgroundColor=[UIColor whiteColor];
        self.bigView.layer.cornerRadius=4;
        self.bigView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.bigView];
        //
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 40, 40)];
        self.leftIV.layer.cornerRadius=20;
        self.leftIV.layer.masksToBounds=YES;
        [self.bigView addSubview:self.leftIV];
        //
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+12, 15, (kScreenWidth-20-36-40)/2, 14)];
        self.nameLab.font=[UIFont systemFontOfSize:14];
        self.nameLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:self.nameLab];
        //
        self.statusLab=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLab.right, 15, (kScreenWidth-20-36-40)/2, 14)];
        self.statusLab.textAlignment=NSTextAlignmentRight;
        self.statusLab.textColor=RGBAColor(255, 150, 0, 1);
        self.statusLab.font=[UIFont systemFontOfSize:12];
        [self.bigView addSubview:self.statusLab];
        //
        self.telephoneLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+12, self.nameLab.bottom+12, 100, 14)];
        self.telephoneLab.font=[UIFont systemFontOfSize:14];
        self.telephoneLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.telephoneLab];
        //
        self.teleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.teleBtn.frame=CGRectMake(self.telephoneLab.right+10, self.nameLab.bottom+11, 16, 16);
        [self.teleBtn setImage:[UIImage imageNamed:@"demand_telephone"] forState:UIControlStateNormal];
        [self.teleBtn addTarget:self action:@selector(teleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.teleBtn];
        //
        self.demandLab=[[UILabel alloc]init];
        self.demandLab.font=[UIFont systemFontOfSize:14];
        self.demandLab.textColor=RGBAColor(51, 51, 51, 1);
        self.demandLab.numberOfLines=3;
        [self.bigView addSubview:self.demandLab];
        //
        self.lookLab=[[UILabel alloc]init];
        self.lookLab.font=[UIFont systemFontOfSize:14];
        self.lookLab.textColor=RGBAColor(0, 92, 175, 1);
        self.lookLab.text=@"查看详情 >>";
        [self.bigView addSubview:self.lookLab];
        //
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.font=[UIFont systemFontOfSize:12];
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.bigView addSubview:self.timeLab];
        //
        self.demandLab.sd_layout
        .leftSpaceToView(self.bigView, 12)
        .topSpaceToView(self.leftIV, 30)
        .rightSpaceToView(self.bigView, 12)
        .autoHeightRatio(0);
        [self.demandLab setMaxNumberOfLinesToShow:3];
        //
        self.lookLab.sd_layout
        .leftEqualToView(self.leftIV)
        .topSpaceToView(self.demandLab, 20)
        .heightIs(14)
        .widthIs(120);
        //
        self.timeLab.sd_layout
        .rightSpaceToView(self.bigView, 12)
        .centerYEqualToView(self.lookLab)
        .heightIs(14)
        .leftSpaceToView(self.lookLab, 15);
        //
        self.bigView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10);
        [self.bigView setupAutoHeightWithBottomView:self.lookLab bottomMargin:20];
    }
    return self;
}
-(void)setModel:(ClientDemandListModel *)model{
    _model=model;
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.photo]];
    self.nameLab.text=_model.linker;
    self.statusLab.text=_model.pstatus;
    self.telephoneLab.text=_model.linkphone;
    self.demandLab.text=_model.demand;
    self.timeLab.text=_model.create_time;
    [self setupAutoHeightWithBottomView:self.bigView bottomMargin:0];
    
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
