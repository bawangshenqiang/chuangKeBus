//
//  CheckStatusView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CheckStatusView.h"

@implementation CheckStatusView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 30)];
        leftLab.text=@"审核状态:";
        leftLab.font=[UIFont systemFontOfSize:13];
        leftLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self addSubview:leftLab];
        //
        
    }
    return self;
}
-(void)setCheckModels:(NSMutableArray<ProjectCheckModel_ChuangYe *> *)checkModels{
    _checkModels=checkModels;
    
    for (int i=0; i<_checkModels.count; i++) {
        ProjectCheckModel_ChuangYe *model=_checkModels[i];
        UILabel *circle=[[UILabel alloc]initWithFrame:CGRectMake(80+60*i, 15-4, 8, 8)];
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
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(80+8+60*i, 0, 32, 30)];
        title.font=[UIFont systemFontOfSize:13];
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor colorWithHexString:@"#323232"];
        [self addSubview:title];
        title.text=model.status;
        //
        if (i<_checkModels.count-1) {
            UIImageView *iv=[[UIImageView alloc]initWithFrame:CGRectMake(80+40+60*i, 15-2.5, 15, 5)];
            iv.image=[UIImage imageNamed:@"project_arrow"];
            [self addSubview:iv];
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
