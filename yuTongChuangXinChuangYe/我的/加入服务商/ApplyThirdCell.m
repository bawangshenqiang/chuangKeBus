//
//  ApplyThirdCell.m
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/15.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "ApplyThirdCell.h"

@implementation ApplyThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 15)];
        self.topLab.font=[UIFont systemFontOfSize:14];
        self.topLab.textColor=[UIColor colorWithHexString:@"#989898"];
        self.topLab.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.topLab];
        
        self.bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(15, self.topLab.bottom+10, 200, 15)];
        self.bottomLab.font=[UIFont systemFontOfSize:16];
        self.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
        self.bottomLab.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.bottomLab];
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
