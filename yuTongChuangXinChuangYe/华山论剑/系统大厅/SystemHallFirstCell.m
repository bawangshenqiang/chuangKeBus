//
//  SystemHallFirstCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemHallFirstCell.h"

@implementation SystemHallFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 66, 66)];
        self.headIV.layer.cornerRadius=33;
        self.headIV.layer.masksToBounds=YES;
        [self.contentView addSubview:self.headIV];
        //
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headIV.right+20, 10, kScreenWidth-40-66, 33)];
        self.nameLab.font=[UIFont systemFontOfSize:16];
        self.nameLab.textColor=RGBAColor(50, 50, 50, 1);
        [self.contentView addSubview:self.nameLab];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headIV.right+20, self.nameLab.bottom, kScreenWidth-40-66, 33)];
        self.titleLab.font=[UIFont systemFontOfSize:12];
        self.titleLab.numberOfLines=0;
        self.titleLab.textColor=RGBAColor(152, 152, 152, 1);
        [self.contentView addSubview:self.titleLab];
        //
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, self.headIV.bottom+14.5, kScreenWidth, 0.5)];
        line.backgroundColor=RGBAColor(200, 200, 200, 1);
        [self.contentView addSubview:line];
    }
    return self;
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
