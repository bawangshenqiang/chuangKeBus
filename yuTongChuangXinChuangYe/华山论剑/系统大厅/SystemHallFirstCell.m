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
        self.headIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.headIV.layer.cornerRadius=20;
        self.headIV.layer.masksToBounds=YES;
        [self.contentView addSubview:self.headIV];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headIV.right+10, 10, kScreenWidth-70, 40)];
        self.titleLab.font=[UIFont systemFontOfSize:15];
        self.titleLab.numberOfLines=0;
        [self.contentView addSubview:self.titleLab];
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
