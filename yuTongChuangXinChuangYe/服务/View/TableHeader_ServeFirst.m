//
//  TableHeader_ServeFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TableHeader_ServeFirst.h"

@implementation TableHeader_ServeFirst
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        NSArray *images=@[@"serve_entrepreneurship",@"serve_course"];
        
        for (int i=0; i<2; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(10+((frame.size.width-30)/2+10)*i, 10, (frame.size.width-30)/2, 60);
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=400+i;
            btn.layer.cornerRadius=5;
            btn.layer.masksToBounds=YES;
            [self addSubview:btn];
        }
    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    if (self.twoBtnClickBlock) {
        self.twoBtnClickBlock(btn.tag-400);
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
