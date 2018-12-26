//
//  TicketRecordSectionHeader.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TicketRecordSectionHeader.h"

@implementation TicketRecordSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 120, 15)];
        self.timeLab.font=[UIFont systemFontOfSize:14];
        self.timeLab.textColor=RGBAColor(153, 153, 153, 1);
        [self.contentView addSubview:self.timeLab];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
