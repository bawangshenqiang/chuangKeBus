//
//  AuditSegmentView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AuditSegmentView.h"

@implementation AuditSegmentView

-(void)setArray:(NSMutableArray *)array{
    _array=array;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ProjectCheckModel_ChuangYe *model1=_array.firstObject;
    ProjectCheckModel_ChuangYe *model2=_array[1];
    ProjectCheckModel_ChuangYe *model3=_array.lastObject;
    if (model3.note.length>0) {
        UILabel *lab1=[[UILabel alloc]init];
        lab1.text=model1.status;
        lab1.textAlignment=NSTextAlignmentCenter;
        lab1.font=[UIFont systemFontOfSize:14];
        lab1.textColor=RGBAColor(51, 51, 51, 1);
        lab1.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
        lab1.layer.borderWidth=1;
        [self addSubview:lab1];
        //
        UILabel *lab2=[[UILabel alloc]init];
        lab2.font=[UIFont systemFontOfSize:14];
        lab2.textColor=RGBAColor(51, 51, 51, 1);
        lab2.numberOfLines=0;
        lab2.text=model1.note;
        [self addSubview:lab2];
        //
        UILabel *lab3=[[UILabel alloc]init];
        lab3.text=model2.status;
        lab3.textAlignment=NSTextAlignmentCenter;
        lab3.font=[UIFont systemFontOfSize:14];
        lab3.textColor=RGBAColor(51, 51, 51, 1);
        lab3.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
        lab3.layer.borderWidth=1;
        [self addSubview:lab3];
        //
        UILabel *lab4=[[UILabel alloc]init];
        lab4.font=[UIFont systemFontOfSize:14];
        lab4.textColor=RGBAColor(51, 51, 51, 1);
        lab4.numberOfLines=0;
        lab4.text=model2.note;
        [self addSubview:lab4];
        //
        //
        UILabel *lab5=[[UILabel alloc]init];
        lab5.text=model3.status;
        lab5.textAlignment=NSTextAlignmentCenter;
        lab5.font=[UIFont systemFontOfSize:14];
        lab5.textColor=RGBAColor(51, 51, 51, 1);
        lab5.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
        lab5.layer.borderWidth=1;
        [self addSubview:lab5];
        //
        UILabel *lab6=[[UILabel alloc]init];
        lab6.font=[UIFont systemFontOfSize:14];
        lab6.textColor=RGBAColor(51, 51, 51, 1);
        lab6.numberOfLines=0;
        lab6.text=model3.note;
        [self addSubview:lab6];
        //
        lab1.sd_layout
        .leftEqualToView(self)
        .topEqualToView(self)
        .widthIs(70)
        .heightIs(24);
        lab1.sd_cornerRadius=@(12);
        //
        lab2.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(lab1, 10)
        .autoHeightRatio(0);
        //
        lab3.sd_layout
        .leftEqualToView(self)
        .topSpaceToView(lab2, 14)
        .widthIs(70)
        .heightIs(24);
        lab3.sd_cornerRadius=@(12);
        //
        lab4.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(lab3, 10)
        .autoHeightRatio(0);
        //
        lab5.sd_layout
        .leftEqualToView(self)
        .topSpaceToView(lab4, 14)
        .widthIs(70)
        .heightIs(24);
        lab5.sd_cornerRadius=@(12);
        //
        lab6.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .topSpaceToView(lab5, 10)
        .autoHeightRatio(0);
        //
        [self setupAutoHeightWithBottomView:lab6 bottomMargin:0];
    }else{
        if (model2.note.length>0) {
            UILabel *lab1=[[UILabel alloc]init];
            lab1.text=model1.status;
            lab1.textAlignment=NSTextAlignmentCenter;
            lab1.font=[UIFont systemFontOfSize:14];
            lab1.textColor=RGBAColor(51, 51, 51, 1);
            lab1.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
            lab1.layer.borderWidth=1;
            [self addSubview:lab1];
            //
            UILabel *lab2=[[UILabel alloc]init];
            lab2.font=[UIFont systemFontOfSize:14];
            lab2.textColor=RGBAColor(51, 51, 51, 1);
            lab2.numberOfLines=0;
            lab2.text=model1.note;
            [self addSubview:lab2];
            //
            UILabel *lab3=[[UILabel alloc]init];
            lab3.text=model2.status;
            lab3.textAlignment=NSTextAlignmentCenter;
            lab3.font=[UIFont systemFontOfSize:14];
            lab3.textColor=RGBAColor(51, 51, 51, 1);
            lab3.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
            lab3.layer.borderWidth=1;
            [self addSubview:lab3];
            //
            UILabel *lab4=[[UILabel alloc]init];
            lab4.font=[UIFont systemFontOfSize:14];
            lab4.textColor=RGBAColor(51, 51, 51, 1);
            lab4.numberOfLines=0;
            lab4.text=model2.note;
            [self addSubview:lab4];
            //
            
            lab1.sd_layout
            .leftEqualToView(self)
            .topEqualToView(self)
            .widthIs(70)
            .heightIs(24);
            lab1.sd_cornerRadius=@(12);
            //
            lab2.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topSpaceToView(lab1, 10)
            .autoHeightRatio(0);
            //
            lab3.sd_layout
            .leftEqualToView(self)
            .topSpaceToView(lab2, 14)
            .widthIs(70)
            .heightIs(24);
            lab3.sd_cornerRadius=@(12);
            //
            lab4.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topSpaceToView(lab3, 10)
            .autoHeightRatio(0);
            
            //
            [self setupAutoHeightWithBottomView:lab4 bottomMargin:0];
        }else{
            UILabel *lab1=[[UILabel alloc]init];
            lab1.text=model1.status;
            lab1.textAlignment=NSTextAlignmentCenter;
            lab1.font=[UIFont systemFontOfSize:14];
            lab1.textColor=RGBAColor(51, 51, 51, 1);
            lab1.layer.borderColor=RGBAColor(51, 51, 51, 1).CGColor;
            lab1.layer.borderWidth=1;
            [self addSubview:lab1];
            //
            UILabel *lab2=[[UILabel alloc]init];
            lab2.font=[UIFont systemFontOfSize:14];
            lab2.textColor=RGBAColor(51, 51, 51, 1);
            lab2.numberOfLines=0;
            lab2.text=model1.note;
            [self addSubview:lab2];
            
            //
            
            lab1.sd_layout
            .leftEqualToView(self)
            .topEqualToView(self)
            .widthIs(70)
            .heightIs(24);
            lab1.sd_cornerRadius=@(12);
            //
            lab2.sd_layout
            .leftEqualToView(self)
            .rightEqualToView(self)
            .topSpaceToView(lab1, 10)
            .autoHeightRatio(0);
            
            //
            [self setupAutoHeightWithBottomView:lab2 bottomMargin:0];
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
