//
//  SystemTableViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemTableViewCell.h"

@implementation SystemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, (kScreenWidth-45)/2, 14)];
        self.titleLab.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.titleLab];
        //
        self.subTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.titleLab.right, 15, (kScreenWidth-45)/2, 14)];
        self.subTitle.font=[UIFont systemFontOfSize:14];
        self.subTitle.textColor=RGBAColor(102, 102, 102, 1);
        self.subTitle.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.subTitle];
//        //
//        self.rightIV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-20-15-14, 15, 14, 14)];
//        self.rightIV.image=[UIImage imageNamed:@"install_return"];
//        [self.contentView addSubview:self.rightIV];
        //
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(15, self.titleLab.bottom+14.5, kScreenWidth-30-20, 0.5)];
        self.separatorLine.backgroundColor=RGBAColor(165, 165, 165, 0.5);
        [self.contentView addSubview:self.separatorLine];
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
