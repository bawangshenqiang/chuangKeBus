//
//  Hot_24.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Hot_24.h"

@implementation Hot_24
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabs=[NSMutableArray array];
        self.backgroundColor=[UIColor whiteColor];
        //
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30*kBaseHeight)];
        self.topLab.font=[UIFont boldSystemFontOfSize:20];
        NSString *string=@"24h热议";
        NSMutableAttributedString *attriString=[[NSMutableAttributedString alloc]initWithString:string];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#323232"] range:NSMakeRange(0, string.length-2)];
        [attriString addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(string.length-2, 2)];
        self.topLab.attributedText=attriString;
        [self addSubview:self.topLab];
        //
        NSDate *date=[NSDate date];
        //
        self.monthLab=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-15-30, 15, 30, 13)];
        self.monthLab.text=[NSString stringWithFormat:@"%d月",(int)date.month];
        self.monthLab.font=[UIFont systemFontOfSize:10];
        self.monthLab.textColor=[UIColor lightGrayColor];
        self.monthLab.textAlignment=NSTextAlignmentCenter;
        self.monthLab.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.monthLab.layer.borderWidth=0.4;
        [self addSubview:self.monthLab];
        //
        self.dayLab=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-15-30, self.monthLab.bottom, 30, 17)];
        self.dayLab.text=[NSString stringWithFormat:@"%d",(int)date.day];
        self.dayLab.font=[UIFont systemFontOfSize:12];
        self.dayLab.textColor=kThemeColor;
        self.dayLab.textAlignment=NSTextAlignmentCenter;
        self.dayLab.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.dayLab.layer.borderWidth=0.4;
        [self addSubview:self.dayLab];
        //
        for (int i=0; i<3; i++) {
            //
            UIView *dot=[[UIView alloc]initWithFrame:CGRectMake(15, (35+15+30*i)*kBaseHeight, 5*kBaseHeight, 5*kBaseHeight)];
            dot.backgroundColor=kThemeColor;
            dot.layer.cornerRadius=2.5*kBaseHeight;
            dot.layer.masksToBounds=YES;
            [self addSubview:dot];
            //
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(25, (35+15+30*i)*kBaseHeight, frame.size.width-40, 15*kBaseHeight)];
            
            lab.tag=300+i;
            lab.numberOfLines=1;
            lab.font=[UIFont systemFontOfSize:16];
            lab.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectACell:)];
            [lab addGestureRecognizer:tap];
            
            [self addSubview:lab];
            [self.titleLabs addObject:lab];
            
            dot.center=CGPointMake(dot.centerX, lab.centerY);
            
        }
        
    }
    return self;
}
-(void)setTitles:(NSMutableArray *)titles{
    _titles=titles;
    if (_titles.count==3) {
        for (int i=0; i<3; i++) {
            UILabel *lab=self.titleLabs[i];
            lab.text=_titles[i][@"title"];
        }
        
    }
}
-(void)selectACell:(UITapGestureRecognizer *)tap{
    
    if (self.Hot_24ClickBlock) {
        self.Hot_24ClickBlock([_titles[tap.view.tag-300][@"id"] integerValue]);
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
