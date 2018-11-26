//
//  HotImageCell_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HotImageCell_HallFirst.h"

@implementation HotImageCell_HallFirst
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bigIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 120)];
        self.bigIV.image=[UIImage imageNamed:@"hall_diagram"];
        self.bigIV.layer.cornerRadius=5;
        self.bigIV.layer.masksToBounds=YES;
        self.bigIV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
        [self.bigIV addGestureRecognizer:tap];
        [self.contentView addSubview:self.bigIV];
    }
    return self;
}
-(void)setModel:(Hall_HomeTodayHotModel *)model{
    _model=model;
    [self.bigIV sd_setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:[UIImage imageNamed:@"hall_diagram"]];
}
-(void)clickImage{
    if (self.ImageClickBlock) {
        self.ImageClickBlock(_model);
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
