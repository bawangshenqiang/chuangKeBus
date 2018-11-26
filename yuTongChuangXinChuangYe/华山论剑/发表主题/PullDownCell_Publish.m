//
//  PullDownCell_Publish.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PullDownCell_Publish.h"

@implementation PullDownCell_Publish

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        self.choseStyle=[[LMJDropdownMenu alloc]init];
        self.choseStyle.frame=CGRectMake(0, 0, kScreenWidth-5, 44);
        //[self.choseStyle setMenuTitles:@[@"系统大厅",@"行业交流",@"综合讨论"] rowHeight:40];
        [self.choseStyle.mainBtn setTitle:@"请选择版块" forState:UIControlStateNormal];
        
        [self addSubview:self.choseStyle];
    }
    return self;
}
-(void)setTitleArr:(NSMutableArray *)titleArr{
    _titleArr=titleArr;
    [self.choseStyle setMenuTitles:_titleArr rowHeight:40];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
