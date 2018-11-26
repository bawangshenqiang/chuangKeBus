//
//  Head_BusinessCourse.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Head_BusinessCourse.h"

@interface Head_BusinessCourse ()
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,strong)NSMutableArray *lineArr;
@end

@implementation Head_BusinessCourse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.btnArr=[NSMutableArray array];
        self.lineArr=[NSMutableArray array];
        self.showsHorizontalScrollIndicator=NO;
        _selectedIndex=0;
        _bgColor=[UIColor whiteColor];
        
    }
    return self;
}
-(void)setTitleArr:(NSMutableArray *)titleArr{
    _titleArr=titleArr;
    self.backgroundColor=_bgColor;
    [self.btnArr removeAllObjects];
    [self.lineArr removeAllObjects];
    UIView *left=self;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<_titleArr.count; i++) {
        NSDictionary *dic=_titleArr[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:kThemeColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=_bgColor;
        btn.titleLabel.font=[UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=kThemeColor;
        [self addSubview:line];
        [self.lineArr addObject:line];
        
        if (i==_selectedIndex) {
            btn.selected=YES;
            line.hidden=NO;
        }else{
            btn.selected=NO;
            line.hidden=YES;
        }
        
        btn.sd_layout
        .leftSpaceToView(left, 0)
        .topSpaceToView(self, 10);
        [btn setupAutoSizeWithHorizontalPadding:15 buttonHeight:20];
        
        line.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn, 5)
        .widthRatioToView(btn, 0.6)
        .heightIs(2);
        
        left=btn;
        
    }
    
    [self setupAutoContentSizeWithRightView:left rightMargin:0];
    
}
-(void)setFixedTitles:(NSArray *)fixedTitles{
    _fixedTitles=fixedTitles;
    self.backgroundColor=_bgColor;
    [self.btnArr removeAllObjects];
    [self.lineArr removeAllObjects];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width=kScreenWidth/_fixedTitles.count;
    for (int i=0; i<_fixedTitles.count; i++) {
        NSString *str=_fixedTitles[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(width * i, 10, width, 20);
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:kThemeColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=_bgColor;
        btn.titleLabel.font=[UIFont systemFontOfSize:18];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(width * i, btn.bottom+5, width * 0.6, 2)];
        line.center=CGPointMake(btn.centerX, line.centerY);
        line.backgroundColor=kThemeColor;
        [self addSubview:line];
        [self.lineArr addObject:line];
        
        if (i==_selectedIndex) {
            btn.selected=YES;
            line.hidden=NO;
        }else{
            btn.selected=NO;
            line.hidden=YES;
        }
    }
    
    self.contentSize=CGSizeMake(kScreenWidth, 0);
    self.scrollEnabled=NO;
}
-(void)btnClick:(UIButton *)btn{
    for (int i=0; i<self.btnArr.count; i++) {
        UIButton*b=self.btnArr[i];
        UIView *line=self.lineArr[i];
        
        b.selected=NO;
        line.hidden=YES;
        if ([btn isEqual:b]) {
            btn.selected=YES;
            line.hidden=NO;
            if (self.topSegmentChangeBlock) {
                self.topSegmentChangeBlock(i);
            }
            
        }
    }
    
}
-(void)setSearchTitleArr:(NSMutableArray *)searchTitleArr{
    _searchTitleArr=searchTitleArr;
    self.backgroundColor=_bgColor;
    [self.btnArr removeAllObjects];
    [self.lineArr removeAllObjects];
    UIView *left=self;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i=0; i<_searchTitleArr.count; i++) {
        NSDictionary *dic=_searchTitleArr[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"%@  %@",dic[@"module"],dic[@"count"]] forState:UIControlStateNormal];
        [btn setTitleColor:kThemeColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=_bgColor;
        btn.titleLabel.font=[UIFont systemFontOfSize:17];
        [btn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=kThemeColor;
        [self addSubview:line];
        [self.lineArr addObject:line];
        
        if (i==_selectedIndex) {
            btn.selected=YES;
            line.hidden=NO;
        }else{
            btn.selected=NO;
            line.hidden=YES;
        }
        
        btn.sd_layout
        .leftSpaceToView(left, 0)
        .topSpaceToView(self, 10);
        [btn setupAutoSizeWithHorizontalPadding:15 buttonHeight:20];
        
        line.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn, 5)
        .widthRatioToView(btn, 0.6)
        .heightIs(2);
        
        left=btn;
        
    }
    
    [self setupAutoContentSizeWithRightView:left rightMargin:0];
    
}
-(void)searchBtnClick:(UIButton *)btn{
    for (int i=0; i<self.btnArr.count; i++) {
        UIButton*b=self.btnArr[i];
        UIView *line=self.lineArr[i];
        
        b.selected=NO;
        line.hidden=YES;
        if ([btn isEqual:b]) {
            btn.selected=YES;
            line.hidden=NO;
            NSString *str=[btn.titleLabel.text componentsSeparatedByString:@"  "].firstObject;
            if (self.topSegmentChangeSecondBlock) {
                self.topSegmentChangeSecondBlock(str);
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
