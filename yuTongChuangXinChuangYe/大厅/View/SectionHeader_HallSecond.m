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
        //
        //加一个更多的按钮
        UIButton *more=[UIButton buttonWithType:UIButtonTypeCustom];
        [more setTitle:@"更多" forState:UIControlStateNormal];
        [more setTitleColor:kThemeColor forState:UIControlStateNormal];
        more.titleLabel.font=[UIFont systemFontOfSize:13];
        [more addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:more];
        more.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.titleLab);
        [more setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    }
    return self;
}
-(void)moreClick{
    if (self.moreBtnBlock) {
        self.moreBtnBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
