//
//  ClearCacheCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ClearCacheCell.h"

@implementation ClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.topTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 15)];
        self.topTitle.text=@"清空缓存";
        [self.contentView addSubview:self.topTitle];
        self.bottomTitle=[[UILabel alloc]initWithFrame:CGRectMake(self.topTitle.left, self.topTitle.bottom+10, kScreenWidth-35, 15)];
        self.bottomTitle.font=[UIFont systemFontOfSize:15];
        self.bottomTitle.textColor=[UIColor colorWithHexString:@"#cccccc"];
        self.bottomTitle.text=@"包括图片、视频缓存等";
        [self.contentView addSubview:self.bottomTitle];
        self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(self.topTitle.right, 0, kScreenWidth-35-self.topTitle.width, 60)];
        self.contentLab.textAlignment=NSTextAlignmentRight;
        self.contentLab.font=[UIFont systemFontOfSize:15];
        self.contentLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:self.contentLab];
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
