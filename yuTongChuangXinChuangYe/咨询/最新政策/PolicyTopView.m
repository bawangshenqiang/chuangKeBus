//
//  PolicyTopView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PolicyTopView.h"

@interface PolicyTopView()
@property(nonatomic,strong)NSMutableArray *btnArr;

@end
@implementation PolicyTopView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArr=[NSMutableArray array];
        //
        CGFloat width=frame.size.width/titleArr.count;
        CGFloat height=frame.size.height;
        UIView *left=nil;
        
        for (int i=0; i<titleArr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            //btn.frame=CGRectMake(width*i, 0, width, height);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kThemeColor] forState:UIControlStateSelected];
            btn.tag=1000+i;
            if (i==0) {
                btn.selected=YES;
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btnArr addObject:btn];
            //
            btn.sd_layout
            .leftSpaceToView(left, 0)
            .topEqualToView(self)
            .widthIs(width)
            .heightIs(height);
            btn.imageView.sd_layout
            .centerYEqualToView(btn)
            .widthIs(15)
            .heightIs(15)
            .centerXIs(btn.centerX-10-15);
            btn.titleLabel.sd_layout
            .centerYEqualToView(btn)
            .heightRatioToView(btn, 1)
            .leftSpaceToView(btn.imageView, 10)
            .widthIs(btn.width/2);
            
            left=btn;
        }
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
    }
    return self;
}
-(void)setImage:(NSArray *)imageArr andSelectedImage:(NSArray *)selectedImage{
    for (int i=0; i<self.btnArr.count; i++) {
        UIButton *btn=self.btnArr[i];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedImage[i]] forState:UIControlStateSelected];
    }
    
}
-(void)btnClick:(UIButton *)btn{
    for (int i=0; i<self.btnArr.count; i++) {
        UIButton *b=self.btnArr[i];
        b.selected=NO;
        if ([b isEqual:btn]) {
            btn.selected=YES;
            if (self.buttonClickBlock) {
                self.buttonClickBlock(btn.tag);
            }
        }
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
