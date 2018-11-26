//
//  ResourceHeaderView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceHeaderView.h"

@implementation ResourceHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
        self.titleLab.font=[UIFont systemFontOfSize:15];
        self.titleLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
