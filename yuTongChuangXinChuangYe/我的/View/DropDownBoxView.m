//
//  DropDownBoxView.m
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/28.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "DropDownBoxView.h"
@interface DropDownBoxView (){
    UIScrollView *baseScroll;
}
@end
@implementation DropDownBoxView

- (void)setFrame:(CGRect)frame{
    
}
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray*)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius=3;
        self.layer.borderWidth=0.5;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.layer.masksToBounds=YES;
        baseScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        baseScroll.showsVerticalScrollIndicator = NO;
        baseScroll.backgroundColor = [UIColor whiteColor];
        baseScroll.contentSize = CGSizeMake(baseScroll.width, titleArr.count * 44);
        [self addSubview:baseScroll];
        //
        for(NSInteger i = 0; i < titleArr.count; i ++){
            UIButton *singleButt = [UIButton buttonWithType:UIButtonTypeCustom];
            singleButt.tag = i;
            singleButt.backgroundColor = kBackgroundColor;
            singleButt.frame = CGRectMake(0, 44 * i, frame.size.width, 44);
            
            [singleButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [singleButt setTitle:titleArr[i] forState:UIControlStateNormal];
            [baseScroll addSubview:singleButt];
            [singleButt addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}
-(void)dismiss{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}
- (void)choseDropDownBoxBlock:(SJDropDownBoxViewBlock)block{
    self.choseDropDownBoxBlock = block;
}
- (void)clickBtn:(UIButton*)btn{
    if (self.choseDropDownBoxBlock) {
        self.choseDropDownBoxBlock(btn.titleLabel.text);
    }
    [self dismiss];
}

@end
