//
//  Header_HuaShan.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/7.
//  Copyright © 2018年 qiyeji. All rights reserved.
//


#import "Header_HuaShan.h"

@interface Header_HuaShan ()
@property(nonatomic,strong)NSMutableArray *btnArr;

@end

@implementation Header_HuaShan
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.btnArr=[NSMutableArray array];
        self.showsHorizontalScrollIndicator=NO;
        
    }
    return self;
}
-(void)setTitleArr:(NSMutableArray *)titleArr{
    _titleArr=titleArr;
    self.backgroundColor=[UIColor whiteColor];
    [self.btnArr removeAllObjects];
    UIView *left=self;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<_titleArr.count; i++) {
        NSDictionary *dic=_titleArr[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"icon"]]]] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        
        btn.sd_layout
        .leftSpaceToView(left, 0)
        .topSpaceToView(self, 0)
        .widthIs(kScreenWidth/(_titleArr.count))
        .heightIs(80);
        btn.imageView.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn, 10)
        .widthIs(45)
        .heightIs(45);
        btn.titleLabel.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn.imageView, 0)
        .widthIs(kScreenWidth/(_titleArr.count))
        .heightIs(25);
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        left=btn;
        
    }
    
    [self setupAutoContentSizeWithRightView:left rightMargin:0];
    
}
-(void)btnClick:(UIButton *)btn{
    for (int i=0; i<self.btnArr.count; i++) {
        UIButton*b=self.btnArr[i];
        
        if ([btn isEqual:b]) {
            if (self.topSegmentChangeBlock) {
                self.topSegmentChangeBlock(i);
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
