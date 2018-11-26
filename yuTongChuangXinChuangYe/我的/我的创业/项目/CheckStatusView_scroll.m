//
//  CheckStatusView_scroll.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CheckStatusView_scroll.h"

@implementation CheckStatusView_scroll

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator=NO;
        
        
        
    }
    return self;
}
-(void)setCheckModels:(NSMutableArray<ProjectCheckModel_ChuangYe *> *)checkModels{
    _checkModels=checkModels;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //
    self.leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 30)];
    self.leftLab.text=@"审核状态:";
    self.leftLab.font=[UIFont systemFontOfSize:13];
    self.leftLab.textColor=[UIColor colorWithHexString:@"#323232"];
    [self addSubview:self.leftLab];
    //
    for (int i=0; i<_checkModels.count; i++) {
        ProjectCheckModel_ChuangYe *model=_checkModels[i];
        UILabel *circle=[[UILabel alloc]initWithFrame:CGRectMake(80+68*i, 15-4, 8, 8)];
        circle.layer.cornerRadius=4;
        circle.layer.masksToBounds=YES;
        [self addSubview:circle];
        if (model.state==0) {
            circle.backgroundColor=[UIColor colorWithHexString:@"#f3932b"];
        }else if (model.state==1){
            circle.backgroundColor=[UIColor colorWithHexString:@"#00e01a"];
        }else if (model.state==2){
            circle.backgroundColor=[UIColor colorWithHexString:@"#ff3131"];
        }else{
            circle.backgroundColor=[UIColor lightGrayColor];
        }
        //
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(80+8+68*i, 0, 40, 30)];
        title.font=[UIFont systemFontOfSize:13];
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor colorWithHexString:@"#323232"];
        [self addSubview:title];
        title.text=model.status;
        //
        if (i<_checkModels.count-1) {
            UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(80+48+68*i, (30-5)/2, 15, 5)];
            iv.image=[UIImage imageNamed:@"project_arrow"];
            [self addSubview:iv];
        }
    }
    
    self.contentSize=CGSizeMake(80+68*_checkModels.count, 30);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
