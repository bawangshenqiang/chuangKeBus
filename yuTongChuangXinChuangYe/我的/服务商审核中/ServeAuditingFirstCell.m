//
//  ServeAuditingFirstCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeAuditingFirstCell.h"

@implementation ServeAuditingFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 80)];
        self.bigView.backgroundColor=[UIColor whiteColor];
        self.bigView.layer.cornerRadius=4;
        [self.contentView addSubview:self.bigView];
        //
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 80, 40)];
        self.leftIV.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
        self.leftIV.layer.borderWidth=0.5;
        [self.bigView addSubview:self.leftIV];
        //
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+10, 20, self.bigView.width-12-80-10-12, 15)];
        self.topLab.font=[UIFont systemFontOfSize:16];
        self.topLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.topLab];
        //
        _flagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_flagBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        _flagBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _flagBtn.layer.borderColor=kThemeColor.CGColor;
        _flagBtn.layer.borderWidth=0.5;
        [self.bigView addSubview:_flagBtn];
        
        _flagBtn.sd_layout
        .leftSpaceToView(self.leftIV, 10)
        .bottomSpaceToView(self.bigView, 16);
        [_flagBtn setupAutoSizeWithHorizontalPadding:8 buttonHeight:16];
        _flagBtn.sd_cornerRadius=@(8);
    }
    return self;
}
-(void)setModel:(JoinServerModel *)model{
    _model=model;
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.logo]];
    self.topLab.text=_model.title;
    [self.flagBtn setTitle:_model.type forState:UIControlStateNormal];
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
