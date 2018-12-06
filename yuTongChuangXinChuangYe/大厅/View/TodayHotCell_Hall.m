//
//  TodayHotCell_Hall.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/4.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TodayHotCell_Hall.h"

@implementation TodayHotCell_Hall

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
//        self.rollingLab=[[YFRollingLabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth-70-12, 60) font:[UIFont systemFontOfSize:14] textColor:RGBAColor(50, 50, 50, 1)];
//        [self.contentView addSubview:self.rollingLab];
        self.scrollLab=[[LMJScrollTextView2 alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth-70-12, 60)];
        self.scrollLab.textFont=[UIFont systemFontOfSize:14];
        self.scrollLab.textColor=RGBAColor(50, 50, 50, 1);
        [self.contentView addSubview:self.scrollLab];
        
        //
        UILabel *today=[[UILabel alloc]init];
        today.text=@"今日";
        today.font=[UIFont systemFontOfSize:12];
        today.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:today];
        //
        UILabel *hot=[[UILabel alloc]init];
        hot.text=@"最热";
        hot.font=[UIFont boldSystemFontOfSize:18];
        hot.textColor=RGBAColor(205, 10, 52, 1);
        [self.contentView addSubview:hot];
        //
        today.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 12)
        .widthIs(40)
        .autoHeightRatio(0);
        //
        hot.sd_layout
        .leftEqualToView(today)
        .bottomSpaceToView(self.contentView, 12)
        .widthIs(40)
        .autoHeightRatio(0);
        
        
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
