//
//  ProjectFooter.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectFooter.h"

@implementation ProjectFooter
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=kBackgroundColor;
        //
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(24, 20, kScreenWidth-24-15, 15)];
        lab1.text=@"预计1-2天完成审核";
        lab1.textColor=RGBAColor(102, 102, 102, 1);
        lab1.font=[UIFont systemFontOfSize:12];
        lab1.backgroundColor=kBackgroundColor;
        [self.contentView addSubview:lab1];
        //
        UILabel *yellow=[[UILabel alloc]initWithFrame:CGRectMake(24, lab1.bottom+15, 15, 15)];
        yellow.backgroundColor=RGBAColor(240, 173, 78, 1);
        [self.contentView addSubview:yellow];
        //
        UILabel *yellow_right=[[UILabel alloc]initWithFrame:CGRectMake(yellow.right+20, lab1.bottom+15, 200, 15)];
        yellow_right.text=@"当前阶段正在审核";
        yellow_right.font=[UIFont systemFontOfSize:12];
        yellow_right.backgroundColor=kBackgroundColor;
        yellow_right.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:yellow_right];
        //
        UILabel *green=[[UILabel alloc]initWithFrame:CGRectMake(24, yellow.bottom+10, 15, 15)];
        green.backgroundColor=RGBAColor(126, 226, 0, 1);
        [self.contentView addSubview:green];
        //
        UILabel *green_right=[[UILabel alloc]initWithFrame:CGRectMake(green.right+20, yellow_right.bottom+10, 200, 15)];
        green_right.text=@"当前阶段审核通过";
        green_right.font=[UIFont systemFontOfSize:12];
        green_right.backgroundColor=kBackgroundColor;
        green_right.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:green_right];
        //
        UILabel *red=[[UILabel alloc]initWithFrame:CGRectMake(24, green.bottom+10, 15, 15)];
        red.backgroundColor=RGBAColor(240, 17, 0, 1);
        [self.contentView addSubview:red];
        //
        UILabel *red_right=[[UILabel alloc]initWithFrame:CGRectMake(red.right+20, green_right.bottom+10, 200, 15)];
        red_right.text=@"当前阶段审核未通过";
        red_right.font=[UIFont systemFontOfSize:12];
        red_right.backgroundColor=kBackgroundColor;
        red_right.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:red_right];
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
