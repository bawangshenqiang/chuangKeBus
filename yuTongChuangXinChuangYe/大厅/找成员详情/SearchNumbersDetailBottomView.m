//
//  SearchNumbersDetailBottomView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchNumbersDetailBottomView.h"

@implementation SearchNumbersDetailBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        //
        self.praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.praiseBtn.frame=CGRectMake((kScreenWidth-3*30)/4, 10, 30, 30);
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap_nor"] forState:UIControlStateSelected];
        [self.praiseBtn addTarget:self action:@selector(praiseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.praiseBtn];
        //
        self.countLab=[[UILabel alloc]initWithFrame:CGRectMake(self.praiseBtn.right, 10, 60, 30)];
        self.countLab.font=[UIFont systemFontOfSize:12];
        self.countLab.textColor=kThemeColor;
        //self.countLab.text=@"123";
        [self addSubview:self.countLab];
        //
        self.interestBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.interestBtn.frame=CGRectMake(self.praiseBtn.right+(kScreenWidth-3*30)/4, 10, 30, 30);
        [self.interestBtn setImage:[UIImage imageNamed:@"member_beinterestedin"] forState:UIControlStateNormal];
        [self.interestBtn setImage:[UIImage imageNamed:@"member_beinterestedin_nor"] forState:UIControlStateSelected];
        [self.interestBtn addTarget:self action:@selector(interestBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.interestBtn];
        //
        self.interestLab=[[UILabel alloc]initWithFrame:CGRectMake(self.interestBtn.right, 10, 60, 30)];
        self.interestLab.font=[UIFont systemFontOfSize:12];
        self.interestLab.textColor=kThemeColor;
        [self addSubview:self.interestLab];
        //
        self.sharedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sharedBtn.frame=CGRectMake(self.interestBtn.right+(kScreenWidth-3*30)/4, 10, 30, 30);
        [self.sharedBtn setImage:[UIImage imageNamed:@"project_reposter"] forState:UIControlStateNormal];
        [self.sharedBtn addTarget:self action:@selector(sharedBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sharedBtn];
        //
    }
    return self;
}

-(void)praiseBtnClick{
    //self.praiseBtn.selected=!self.praiseBtn.isSelected;
    if (self.praiseBtnBlock) {
        self.praiseBtnBlock();
    }
    
}
-(void)interestBtnClick{
    //self.interestBtn.selected=!self.interestBtn.isSelected;
    //已经感兴趣的不能再次取消感兴趣
    if (self.interestBtn.isSelected==YES) {
        return;
    }
    if (self.interestBtnBlock) {
        self.interestBtnBlock();
    }
    
}
-(void)sharedBtnClick{
    if (self.sharedBtnBlock) {
        self.sharedBtnBlock();
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
