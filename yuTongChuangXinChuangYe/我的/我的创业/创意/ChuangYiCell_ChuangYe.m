//
//  ChuangYiCell_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ChuangYiCell_ChuangYe.h"

@implementation ChuangYiCell_ChuangYe
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 0)];
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.outBig.layer.cornerRadius=5;
        self.outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:self.outBig];
        //
        self.topView=[[ChuangYiCellTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 95)];
        [self.outBig addSubview:self.topView];
        //
        _statusCircle=[[UILabel alloc]init];
        [self.outBig addSubview:_statusCircle];
        
        //
        _statusLab=[[UILabel alloc]init];
        _statusLab.font=[UIFont systemFontOfSize:13];
        _statusLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.outBig addSubview:_statusLab];
        
        //
        _checkIdea=[[UILabel alloc]init];
        _checkIdea.font=[UIFont systemFontOfSize:13];
        _checkIdea.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.outBig addSubview:_checkIdea];
        
        _statusCircle.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .centerYIs(self.topView.bottom+15)
        .widthIs(8)
        .heightIs(8);
        _statusCircle.sd_cornerRadius=@(4);
        
        _statusLab.sd_layout
        .leftSpaceToView(self.statusCircle, 5)
        .topSpaceToView(self.topView, 0)
        .rightEqualToView(self.topView)
        .heightIs(30);
        
        _checkIdea.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.statusLab, 0)
        .rightSpaceToView(self.outBig, 10)
        .heightIs(20);
        
        self.outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [self.outBig setupAutoHeightWithBottomView:_checkIdea bottomMargin:0];
    }
    return self;
}
-(void)setModel:(ChuangYiModel_ChuangYe *)model{
    _model=model;
    if (_model.checkIdea.length) {
        
        [self.topView.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"picture"]];
        self.topView.rightLab.text=_model.title;
        [self.topView.flagBtn setTitle:_model.flagStr forState:UIControlStateNormal];
        self.topView.studyLab.text=_model.times;
        
        self.statusCircle.backgroundColor=[UIColor colorWithHexString:@"#ff3131"];
        self.statusLab.text=_model.checkStatus;
        self.checkIdea.hidden=NO;
        self.checkIdea.text=[NSString stringWithFormat:@"审核意见:%@",_model.checkIdea];
        [self.outBig setupAutoHeightWithBottomView:_checkIdea bottomMargin:0];
    }else{
        
        [self.topView.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"picture"]];
        self.topView.rightLab.text=_model.title;
        [self.topView.flagBtn setTitle:_model.flagStr forState:UIControlStateNormal];
        self.topView.studyLab.text=_model.times;
        
        if ([_model.checkStatus isEqualToString:@"已审核"]) {
            self.statusCircle.backgroundColor=[UIColor colorWithHexString:@"#00e01a"];
        }else if([_model.checkStatus isEqualToString:@"待修改"]){
            self.statusCircle.backgroundColor=[UIColor colorWithHexString:@"#ff3131"];
        }else{
            self.statusCircle.backgroundColor=[UIColor colorWithHexString:@"#f3932b"];
        }
        self.statusLab.text=_model.checkStatus;
        self.checkIdea.hidden=YES;
        [self.outBig setupAutoHeightWithBottomView:_statusLab bottomMargin:0];
    }
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:10];
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
