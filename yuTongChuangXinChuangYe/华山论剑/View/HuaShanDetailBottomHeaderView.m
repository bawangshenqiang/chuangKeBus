//
//  HuaShanDetailBottomHeaderView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanDetailBottomHeaderView.h"

@implementation HuaShanDetailBottomHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        //
        self.praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.praiseBtn.frame=CGRectMake((kScreenWidth-4*30)/5, 10, 30, 30);
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap_nor"] forState:UIControlStateSelected];
        [self.praiseBtn addTarget:self action:@selector(praiseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.praiseBtn];
        //
        self.praiseLab=[[UILabel alloc]initWithFrame:CGRectMake(self.praiseBtn.right, 10, 50, 30)];
        self.praiseLab.font=[UIFont systemFontOfSize:12];
        self.praiseLab.textColor=kThemeColor;
        [self addSubview:self.praiseLab];
        //
        self.collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.collectBtn.frame=CGRectMake(self.praiseBtn.right+(kScreenWidth-4*30)/5, 10, 30, 30);
        [self.collectBtn setImage:[UIImage imageNamed:@"systemhall_collect"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"systemhall_collect_nor"] forState:UIControlStateSelected];
        [self.collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.collectBtn];
        //
        self.collectLab=[[UILabel alloc]initWithFrame:CGRectMake(self.collectBtn.right, 10, 50, 30)];
        self.collectLab.font=[UIFont systemFontOfSize:12];
        self.collectLab.textColor=kThemeColor;
        [self addSubview:self.collectLab];
        //
        self.commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.commentBtn.frame=CGRectMake(self.collectBtn.right+(kScreenWidth-4*30)/5, 10, 30, 30);
        [self.commentBtn setImage:[UIImage imageNamed:@"systemhall_comment"] forState:UIControlStateNormal];
        [self.commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.commentBtn];
        //
        self.commentLab=[[UILabel alloc]initWithFrame:CGRectMake(self.commentBtn.right, 10, 50, 30)];
        self.commentLab.font=[UIFont systemFontOfSize:12];
        self.commentLab.textColor=kThemeColor;
        [self addSubview:self.commentLab];
        //
        self.sharedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sharedBtn.frame=CGRectMake(self.commentBtn.right+(kScreenWidth-4*30)/5, 10, 30, 30);
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
//    int count=[self.praiseLab.text intValue];
//    if (self.praiseBtn.isSelected) {
//        self.praiseLab.text=[NSString stringWithFormat:@"%d",count+1];
//    }else{
//        if (count>0) {
//            self.praiseLab.text=[NSString stringWithFormat:@"%d",count-1];
//        }
//    }
}
-(void)collectBtnClick{
    //self.collectBtn.selected=!self.collectBtn.isSelected;
    if (self.collectBtnBlock) {
        self.collectBtnBlock();
    }
//    int count=[self.collectLab.text intValue];
//    if (self.collectBtn.isSelected) {
//        self.collectLab.text=[NSString stringWithFormat:@"%d",count+1];
//    }else{
//        if (count>0) {
//            self.collectLab.text=[NSString stringWithFormat:@"%d",count-1];
//        }
//    }
}
-(void)commentBtnClick{
    
    if (self.commentBtnBlock) {
        self.commentBtnBlock();
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
