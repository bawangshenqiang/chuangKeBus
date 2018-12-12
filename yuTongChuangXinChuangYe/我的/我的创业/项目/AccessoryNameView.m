//
//  AccessoryNameView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AccessoryNameView.h"
@interface AccessoryNameView()
@property(nonatomic,strong)NSMutableArray *customArr;
@end

@implementation AccessoryNameView

-(void)setArray:(NSMutableArray *)array{
    _array=array;
    self.customArr=[NSMutableArray array];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ProjectCheckModel_ChuangYe *model1=_array.firstObject;
    ProjectCheckModel_ChuangYe *model2=_array[1];
    ProjectCheckModel_ChuangYe *model3=_array.lastObject;
    if (model3.suggestionfile.length>0&&model2.suggestionfile.length>0&&model1.suggestionfile.length>0) {
        //
        [self.customArr addObject:model1.suggestionfile];
        [self.customArr addObject:model2.suggestionfile];
        [self.customArr addObject:model3.suggestionfile];
        //
        UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitle:model1.suggestion forState:UIControlStateNormal];
        [btn1 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
        btn1.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag=3000;
        [self addSubview:btn1];
        //
        UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:model2.suggestion forState:UIControlStateNormal];
        [btn2 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
        btn2.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag=3001;
        [self addSubview:btn2];
        //
        UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn3 setTitle:model3.suggestion forState:UIControlStateNormal];
        [btn3 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
        btn3.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag=3002;
        [self addSubview:btn3];
        //
        btn1.sd_layout
        .leftEqualToView(self)
        .topEqualToView(self);
        [btn1 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
        //
        btn2.sd_layout
        .leftEqualToView(self)
        .topSpaceToView(btn1, 10);
        [btn2 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
        //
        btn3.sd_layout
        .leftEqualToView(self)
        .topSpaceToView(btn2, 10);
        [btn3 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
        //
        [self setupAutoHeightWithBottomView:btn3 bottomMargin:0];
    }else{
        if ((model3.suggestionfile.length==0&&model2.suggestionfile.length>0&&model1.suggestionfile.length>0)||(model3.suggestionfile.length>0&&model2.suggestionfile.length==0&&model1.suggestionfile.length>0)||(model3.suggestionfile.length>0&&model2.suggestionfile.length>0&&model1.suggestionfile.length==0)) {
            //
            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
            btn1.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag=3100;
            [self addSubview:btn1];
            //
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
            btn2.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag=3101;
            [self addSubview:btn2];
            //
            if (model3.suggestionfile.length==0&&model2.suggestionfile.length>0&&model1.suggestionfile.length>0) {
                [btn1 setTitle:model1.suggestion forState:UIControlStateNormal];
                [btn2 setTitle:model2.suggestion forState:UIControlStateNormal];
                [self.customArr addObject:model1.suggestionfile];
                [self.customArr addObject:model2.suggestionfile];
            }else if (model3.suggestionfile.length>0&&model2.suggestionfile.length==0&&model1.suggestionfile.length>0){
                [btn1 setTitle:model1.suggestion forState:UIControlStateNormal];
                [btn2 setTitle:model3.suggestion forState:UIControlStateNormal];
                [self.customArr addObject:model1.suggestionfile];
                [self.customArr addObject:model3.suggestionfile];
            }else{
                [btn1 setTitle:model2.suggestion forState:UIControlStateNormal];
                [btn2 setTitle:model3.suggestion forState:UIControlStateNormal];
                [self.customArr addObject:model2.suggestionfile];
                [self.customArr addObject:model3.suggestionfile];
            }
            //
            btn1.sd_layout
            .leftEqualToView(self)
            .topEqualToView(self);
            [btn1 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
            //
            btn2.sd_layout
            .leftEqualToView(self)
            .topSpaceToView(btn1, 10);
            [btn2 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
            //
            [self setupAutoHeightWithBottomView:btn2 bottomMargin:0];
        }else{
            if (model1.suggestionfile.length>0||model2.suggestionfile.length>0||model3.suggestionfile.length>0) {
                //
                UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setTitleColor:RGBAColor(0, 92, 175, 1) forState:UIControlStateNormal];
                btn1.titleLabel.font=[UIFont systemFontOfSize:14];
                [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn1.tag=3200;
                [self addSubview:btn1];
                if (model1.suggestionfile.length>0) {
                    [btn1 setTitle:model1.suggestion forState:UIControlStateNormal];
                    [self.customArr addObject:model1.suggestionfile];
                }else if (model2.suggestionfile.length>0){
                    [btn1 setTitle:model2.suggestion forState:UIControlStateNormal];
                    [self.customArr addObject:model2.suggestionfile];
                }else{
                    [btn1 setTitle:model3.suggestion forState:UIControlStateNormal];
                    [self.customArr addObject:model3.suggestionfile];
                }
                //
                btn1.sd_layout
                .leftEqualToView(self)
                .topEqualToView(self);
                [btn1 setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
                //
                [self setupAutoHeightWithBottomView:btn1 bottomMargin:0];
            }
        }
        
    }
}
-(void)btnClick:(UIButton *)btn{
    if (self.customArr.count==3) {
        for (int i=0; i<3; i++) {
            NSString *string=self.customArr[i];
            if (i==btn.tag-3000) {
                if (self.btnClickBlock) {
                    self.btnClickBlock(string);
                }
                break;
            }
        }
    }else if (self.customArr.count==2){
        for (int i=0; i<2; i++) {
            NSString *string=self.customArr[i];
            if (i==btn.tag-3100) {
                if (self.btnClickBlock) {
                    self.btnClickBlock(string);
                }
                break;
            }
        }
    }else if (self.customArr.count==1){
        NSString *string=[self.customArr objectAtIndex:0];
        if (self.btnClickBlock) {
            self.btnClickBlock(string);
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
