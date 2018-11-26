//
//  FastInforListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "FastInforListCell.h"

@implementation FastInforListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(9, 10, 17, 17)];
        self.leftIV.image=[UIImage imageNamed:@"newsflash_newsflash"];
        [self.contentView addSubview:self.leftIV];
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont systemFontOfSize:17];
        self.titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
        self.titleLab.numberOfLines=2;
        self.titleLab.userInteractionEnabled=YES;
        [self.contentView addSubview:self.titleLab];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flodClick)];
        [self.titleLab addGestureRecognizer:tap];
        self.bottomView=[[FastInforCellBottomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 0)];
        [self.contentView addSubview:self.bottomView];
        [self.bottomView.shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
        //
        self.titleLab.sd_layout
        .leftSpaceToView(self.contentView, 35)
        .topSpaceToView(self.contentView, 10)
        .widthIs(kScreenWidth-20-35)
        .autoHeightRatio(0);
        [self.titleLab setMaxNumberOfLinesToShow:2];
        
        self.bottomView.sd_layout
        .leftEqualToView(self.contentView)
        .widthIs(kScreenWidth-20)
        .topSpaceToView(self.titleLab, 10);
        [self.bottomView setupAutoHeightWithBottomView:self.bottomView.timeLab bottomMargin:5];
    }
    return self;
}
-(void)shareClick{
    if (self.shareClickBlock) {
        self.shareClickBlock(self.indexPath);
    }
}
-(void)flodClick{
    _model.showBottomView=!_model.showBottomView;
    if (self.flodClickBlock) {
        self.flodClickBlock(self.indexPath);
    }
}
-(void)setModel:(FastInfoListModel *)model{
    _model=model;
    self.titleLab.text=_model.title;
    self.bottomView.detailLab.text=_model.detailTitle;
    self.bottomView.timeLab.text=_model.times;
    self.bottomView.fromLab.text=_model.fromStr;
    UIView *bottomV=nil;
    if (_model.showBottomView) {
        self.bottomView.hidden=NO;
        bottomV=self.bottomView;
    }else{
        self.bottomView.hidden=YES;
        bottomV=self.titleLab;
    }
    [self setupAutoHeightWithBottomView:bottomV bottomMargin:10];
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
