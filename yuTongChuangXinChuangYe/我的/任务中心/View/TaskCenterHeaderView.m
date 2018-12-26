//
//  TaskCenterHeaderView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TaskCenterHeaderView.h"

@implementation TaskCenterHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;//[UIColor whiteColor];
        
        self.topView=[[TastTop alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 87)];
        [self addSubview:self.topView];
        //
        UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, frame.size.width, 40)];
        whiteView.backgroundColor=[UIColor whiteColor];
        [self addSubview:whiteView];
        //
        UILabel *today=[[UILabel alloc]init];
        today.text=@"今日已获取";
        today.font=[UIFont systemFontOfSize:14];
        today.textColor=RGBAColor(51, 51, 51, 1);
        [self addSubview:today];
        //
        self.todayTicket=[[UILabel alloc]init];
        self.todayTicket.font=[UIFont systemFontOfSize:14];
        self.todayTicket.textColor=RGBAColor(255, 150, 0, 1);
        [self addSubview:self.todayTicket];
        //
        UILabel *ticket=[[UILabel alloc]init];
        ticket.text=@"车票";
        ticket.font=[UIFont systemFontOfSize:14];
        ticket.textColor=RGBAColor(51, 51, 51, 1);
        [self addSubview:ticket];
        //
        UIButton *record=[UIButton buttonWithType:UIButtonTypeCustom];
        [record setTitle:@"车票记录" forState:UIControlStateNormal];
        [record setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
        record.titleLabel.font=[UIFont systemFontOfSize:14];
        [record addTarget:self action:@selector(recordClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:record];
        //
        today.sd_layout
        .leftSpaceToView(self, 26)
        .topSpaceToView(self.topView, 13)
        .heightIs(14);
        [today setSingleLineAutoResizeWithMaxWidth:90];
        //
        self.todayTicket.sd_layout
        .leftSpaceToView(today, 0)
        .topEqualToView(today)
        .heightIs(14);
        [self.todayTicket setSingleLineAutoResizeWithMaxWidth:60];
        //
        ticket.sd_layout
        .leftSpaceToView(self.todayTicket, 0)
        .topEqualToView(today)
        .heightIs(14);
        [ticket setSingleLineAutoResizeWithMaxWidth:40];
        //
        record.sd_layout
        .rightSpaceToView(self, 30)
        .topEqualToView(today);
        [record setupAutoSizeWithHorizontalPadding:0 buttonHeight:14];
    }
    return self;
}
-(void)recordClick{
    if (self.recordClickBlock) {
        self.recordClickBlock();
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
