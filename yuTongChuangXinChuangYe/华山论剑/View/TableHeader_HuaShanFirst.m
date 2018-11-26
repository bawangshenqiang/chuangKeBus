//
//  TableHeader_HuaShanFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TableHeader_HuaShanFirst.h"

@implementation TableHeader_HuaShanFirst
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIView *topLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        topLine.backgroundColor=RGBAColor(238, 240, 242, 1);
        [self addSubview:topLine];
        UILabel *topLab=[[UILabel alloc]initWithFrame:CGRectMake(0, topLine.bottom, frame.size.width, 32*kBaseHeight)];
        topLab.text=@"全部版块";
        topLab.textColor=[UIColor colorWithHexString:@"323232"];
        topLab.font=[UIFont boldSystemFontOfSize:18];
        topLab.textAlignment=NSTextAlignmentCenter;
        [self addSubview:topLab];
        UIView *bottomLine=[[UIView alloc]initWithFrame:CGRectMake(0, topLab.bottom, frame.size.width, 0.5)];
        bottomLine.backgroundColor=RGBAColor(238, 240, 242, 1);
        [self addSubview:bottomLine];
        
        //
        NSArray *titleArr=@[@"系统大厅",@"行业交流",@"综合讨论",@"意见反馈"];
        NSArray *imageArray=@[@"huashan_hall",@"huashan_communicate",@"huashan_discuss",@"huashan_feedback"];
        UIView *lastView=nil;
        for (int i=0; i<4; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:kThemeColor forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=700+i;
            [self addSubview:btn];
            //
            btn.sd_layout
            .leftSpaceToView(lastView, 0)
            .topSpaceToView(bottomLine, 0)
            .widthIs(frame.size.width/4)
            .heightIs(60*kBaseHeight);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn, 10*kBaseHeight)
            .widthIs(20*kBaseHeight)
            .heightIs(20*kBaseHeight);
            btn.titleLabel.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn.imageView, 0)
            .widthIs(frame.size.width/4)
            .heightIs(30*kBaseHeight);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            lastView=btn;
        }
        
    }
    return self;
}
-(void)fourBtnClick:(UIButton *)btn{
    if (self.fourBtnClickBlock) {
        self.fourBtnClickBlock(btn.tag);
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
