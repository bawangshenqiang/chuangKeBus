//
//  ServeAuditingThirdCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeAuditingThirdCell.h"

@implementation ServeAuditingThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bigView=[[UIView alloc]init];
        self.bigView.backgroundColor=[UIColor whiteColor];
        self.bigView.layer.cornerRadius=4;
        [self.contentView addSubview:self.bigView];
        //
        UILabel *colorLab=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 5, 20)];
        colorLab.backgroundColor=RGBAColor(255, 150, 0, 1);
        [self.bigView addSubview:colorLab];
        //
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(colorLab.right+12, 15, 100, 20)];
        self.topLab.text=@"审核意见";
        self.topLab.font=[UIFont systemFontOfSize:16];
        self.topLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.topLab];
        //
        self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-20-12-100, 15, 100, 20)];
        self.timeLab.font=[UIFont systemFontOfSize:12];
        self.timeLab.textColor=RGBAColor(153, 153, 153, 1);
        [self.bigView addSubview:self.timeLab];
        //
        self.contentLab=[[UILabel alloc]init];
        self.contentLab.numberOfLines=0;
        self.contentLab.font=[UIFont systemFontOfSize:14];
        self.contentLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.contentLab];
        //
        self.contentLab.sd_layout
        .leftSpaceToView(self.bigView, 28)
        .rightSpaceToView(self.bigView, 12)
        .topSpaceToView(self.topLab, 20)
        .autoHeightRatio(0);
        //
        self.bigView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 0)
        .widthIs(kScreenWidth-20);
        [self.bigView setupAutoHeightWithBottomView:self.contentLab bottomMargin:15];
    }
    return self;
}
-(void)setModel:(JoinServerModel *)model{
    _model=model;
    self.contentLab.text=_model.note;
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
