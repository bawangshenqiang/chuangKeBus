//
//  MoveCollectionViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/22.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MoveCollectionViewCell.h"

@implementation MoveCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        self.titleLab.backgroundColor=[UIColor colorWithHexString:@"#f6f6f6"];
        self.titleLab.font=[UIFont systemFontOfSize:13];
        self.titleLab.textAlignment=NSTextAlignmentCenter;
        self.titleLab.layer.cornerRadius=3;
        self.titleLab.layer.masksToBounds=YES;
        [self addSubview:self.titleLab];
    }
    return self;
}
@end
