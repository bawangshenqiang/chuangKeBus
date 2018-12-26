//
//  TicketRecordCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TicketRecordCell.h"

@implementation TicketRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLab=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24-60, 45)];
        self.leftLab.font=[UIFont systemFontOfSize:16];
        self.leftLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.leftLab];
        //
        self.rightLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-12-45, 0, 45, 45)];
        self.rightLab.font=[UIFont systemFontOfSize:14];
        self.rightLab.textColor=RGBAColor(255, 150, 0, 1);
        self.rightLab.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLab];
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
