//
//  LogoutCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "LogoutCell.h"

@implementation LogoutCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        self.title.text=@"退出登录";
        self.title.textAlignment=NSTextAlignmentCenter;
        self.title.font=[UIFont boldSystemFontOfSize:18];
        self.title.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:self.title];
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
