//
//  ThreeAuditView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ThreeAuditView.h"

@implementation ThreeAuditView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBAColor(255, 255, 255, 0.7);
        self.firstLine=[[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-frame.size.width/3, 18, frame.size.width/3, 2)];
        self.firstLine.backgroundColor=RGBAColor(102, 102, 102, 1);
        [self addSubview:self.firstLine];
        //
        self.secondLine=[[UIView alloc]initWithFrame:CGRectMake(self.firstLine.right, 18, frame.size.width/3, 2)];
        self.secondLine.backgroundColor=RGBAColor(102, 102, 102, 1);
        [self addSubview:self.secondLine];
        //
        self.firstCircle=[[UILabel alloc]initWithFrame:CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12)];
        self.firstCircle.layer.cornerRadius=self.firstCircle.width/2;
        self.firstCircle.layer.masksToBounds=YES;
        self.firstCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        [self addSubview:self.firstCircle];
        //
        self.secondCircle=[[UILabel alloc]initWithFrame:CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12)];
        self.secondCircle.layer.cornerRadius=self.secondCircle.width/2;
        self.secondCircle.layer.masksToBounds=YES;
        self.secondCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        [self addSubview:self.secondCircle];
        //
        self.thirdCircle=[[UILabel alloc]initWithFrame:CGRectMake(self.secondLine.right-6, self.firstLine.y-5, 12, 12)];
        self.thirdCircle.layer.cornerRadius=self.thirdCircle.width/2;
        self.thirdCircle.layer.masksToBounds=YES;
        self.thirdCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        [self addSubview:self.thirdCircle];
        //
        for (int i=0; i<3; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/3*i, frame.size.height-25, frame.size.width/3, 15)];
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:12];
            label.textColor=RGBAColor(51, 51, 51, 1);
            [self addSubview:label];
            switch (i) {
                case 0:
                    self.firstTitle=label;
                    break;
                case 1:
                    self.secondTitle=label;
                    break;
                default:
                    self.thirdTitle=label;
                    break;
            }
        }
    }
    return self;
}
-(void)resetCircleFrameAndLineColor:(int)index{
    //3次审核:   0:等待，1:通过，2:未通过
    if (index==1) {
        //000
        self.firstCircle.frame=CGRectMake(self.firstLine.x-9, self.firstLine.y-8, 18, 18);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-6, self.firstLine.y-5, 12, 12);
        self.firstCircle.layer.cornerRadius=self.firstCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(240, 173, 78, 1);
        self.secondCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.thirdCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.firstLine.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.secondLine.backgroundColor=RGBAColor(102, 102, 102, 1);
    }else if (index==2){
        //200
        self.firstCircle.frame=CGRectMake(self.firstLine.x-9, self.firstLine.y-8, 18, 18);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-6, self.firstLine.y-5, 12, 12);
        self.firstCircle.layer.cornerRadius=self.firstCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(240, 17, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.thirdCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.firstLine.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.secondLine.backgroundColor=RGBAColor(102, 102, 102, 1);
    }else if (index==3){
        //100
        self.firstCircle.frame=CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-9, self.firstLine.y-8, 18, 18);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.layer.cornerRadius=self.secondCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(240, 173, 78, 1);
        self.thirdCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.firstLine.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondLine.backgroundColor=RGBAColor(102, 102, 102, 1);
    }else if (index==4){
        //120
        self.firstCircle.frame=CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-9, self.firstLine.y-8, 18, 18);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.layer.cornerRadius=self.secondCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(240, 17, 0, 1);
        self.thirdCircle.backgroundColor=RGBAColor(102, 102, 102, 1);
        self.firstLine.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondLine.backgroundColor=RGBAColor(102, 102, 102, 1);
    }else if (index==5){
        //110
        self.firstCircle.frame=CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-9, self.firstLine.y-8, 18, 18);
        self.thirdCircle.layer.cornerRadius=self.thirdCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.thirdCircle.backgroundColor=RGBAColor(240, 173, 78, 1);
        self.firstLine.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondLine.backgroundColor=RGBAColor(126, 226, 0, 1);
    }else if (index==6){
        //112
        self.firstCircle.frame=CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-9, self.firstLine.y-8, 18, 18);
        self.thirdCircle.layer.cornerRadius=self.thirdCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.thirdCircle.backgroundColor=RGBAColor(240, 17, 0, 1);
        self.firstLine.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondLine.backgroundColor=RGBAColor(126, 226, 0, 1);
    }else if (index==7){
        //111
        self.firstCircle.frame=CGRectMake(self.firstLine.x-6, self.firstLine.y-5, 12, 12);
        self.secondCircle.frame=CGRectMake(self.firstLine.right-6, self.firstLine.y-5, 12, 12);
        self.thirdCircle.frame=CGRectMake(self.secondLine.right-9, self.firstLine.y-8, 18, 18);
        self.thirdCircle.layer.cornerRadius=self.thirdCircle.width/2;
        self.firstCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.thirdCircle.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.firstLine.backgroundColor=RGBAColor(126, 226, 0, 1);
        self.secondLine.backgroundColor=RGBAColor(126, 226, 0, 1);
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
