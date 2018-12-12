//
//  TipsListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TipsListCell.h"

@implementation TipsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        UILabel *dot=[[UILabel alloc]init];
        dot.backgroundColor=kThemeColor;
        [self.contentView addSubview:dot];
        //
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        self.titleLab.numberOfLines=2;
        self.titleLab.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.titleLab];
        //
        self.separaterLine=[[UIView alloc]init];
        self.separaterLine.backgroundColor=RGBAColor(165, 165, 165, 0.5);
        [self.contentView addSubview:self.separaterLine];
        //
        dot.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .centerYEqualToView(self.contentView)
        .widthIs(8)
        .heightIs(8);
        dot.sd_cornerRadius=@(4);
        //
        self.titleLab.sd_layout
        .leftSpaceToView(dot, 10)
        .rightSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
        [self.titleLab setMaxNumberOfLinesToShow:2];
        //
        self.separaterLine.sd_layout
        .leftEqualToView(dot)
        .rightEqualToView(self.titleLab)
        .topSpaceToView(self.titleLab, 10)
        .heightIs(0.5);
    }
    return self;
}
-(void)setModel:(TipsListModel *)model{
    _model=model;
    self.titleLab.text=_model.title;
    [self setupAutoHeightWithBottomView:self.separaterLine bottomMargin:0];
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
