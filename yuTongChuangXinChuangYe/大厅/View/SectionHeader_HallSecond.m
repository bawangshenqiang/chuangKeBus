//
//  SectionHeader_HallSecond.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/4.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SectionHeader_HallSecond.h"

@implementation SectionHeader_HallSecond
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=kBackgroundColor;
        
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.titleLab];
        
        self.titleLab.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 20)
        .bottomSpaceToView(self.contentView, 10);
        [self.titleLab setSingleLineAutoResizeWithMaxWidth:100];
        
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
