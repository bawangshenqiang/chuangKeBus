//
//  SectionHeader_SystemHall.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SectionHeader_SystemHall.h"

@implementation SectionHeader_SystemHall
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *backV=[[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 42)];
        backV.backgroundColor=[UIColor whiteColor];
        [self addSubview:backV];
        //
        self.choseStyle=[[LMJDropdownMenu alloc]init];
        self.choseStyle.frame=CGRectMake(kScreenWidth-115, 10, 115, 42);
        [self.choseStyle setMenuTitles:@[@"按发帖时间",@"按回复时间"] rowHeight:30];
        [self.choseStyle.mainBtn setTitle:@"按发帖时间" forState:UIControlStateNormal];
        [self.choseStyle.mainBtn setTitleColor:RGBAColor(152, 152, 152, 1) forState:UIControlStateNormal];
        
        [self addSubview:self.choseStyle];
        //
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, self.choseStyle.bottom-0.5, kScreenWidth, 0.5)];
        line.backgroundColor=RGBAColor(200, 200, 200, 0.5);
        [self addSubview:line];
    }
    return self;
}
/**
 * 超出父视图范围，不响应，需要重写父视图的这个方法
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    if (self.userInteractionEnabled == NO && self.alpha <= 0.01 && self.hidden == YES) {
        return nil;
    }
    
    
    if (view == nil) {
        
        for (UIView * subview in self.subviews.reverseObjectEnumerator) {
            
            CGPoint converP = [subview convertPoint:point fromView:self];
            UIView *suitableView = [subview hitTest:converP withEvent:event];
            
            if (suitableView) {
                return suitableView;
            } else {
                return view;
            }
        }
        
    }
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
