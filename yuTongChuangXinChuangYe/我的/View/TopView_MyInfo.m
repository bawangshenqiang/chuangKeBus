//
//  TopView_MyInfo.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TopView_MyInfo.h"

@implementation TopView_MyInfo
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        //
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, kStatusBarHeight+110)];
        [self addSubview:topView];
        //
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0ca4eb"].CGColor, (__bridge id)[UIColor colorWithHexString:@"0384dd"].CGColor];
        gradientLayer.locations = @[@0.0, @0.5, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = topView.frame;
        [self.layer addSublayer:gradientLayer];
        //
        self.headerIV=[[UIImageView alloc]initWithFrame:CGRectMake(30, kStatusBarHeight+20, 45, 45)];
        self.headerIV.image=[UIImage imageNamed:@"mine_user"];
        self.headerIV.layer.cornerRadius=45/2;
        self.headerIV.layer.masksToBounds=YES;
        self.headerIV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setHeaderClick)];
        [self.headerIV addGestureRecognizer:tap];
        [self addSubview:self.headerIV];
        //
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(self.headerIV.right+10, self.headerIV.y, 180, 20)];
        self.nameLab.backgroundColor=[UIColor clearColor];
        self.nameLab.center=CGPointMake(self.nameLab.centerX, self.headerIV.centerY);
        self.nameLab.text=@"登录/注册";
        self.nameLab.textColor=[UIColor whiteColor];
        self.nameLab.font=[UIFont systemFontOfSize:18];
        self.nameLab.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginClick)];
        [self.nameLab addGestureRecognizer:tap1];
        [self addSubview:self.nameLab];
        //
        self.setBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.setBtn.frame=CGRectMake(frame.size.width-60, kStatusBarHeight, 60, 35);
        [self.setBtn setTitle:@"设置" forState:UIControlStateNormal];
        self.setBtn.backgroundColor=[UIColor clearColor];
        [self.setBtn addTarget:self action:@selector(setClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.setBtn];
        //
        UIView *centerV=[[UIView alloc]initWithFrame:CGRectMake(10, topView.bottom-15, frame.size.width-20, 95)];
        centerV.backgroundColor=[UIColor whiteColor];
        centerV.layer.cornerRadius=5;
        centerV.layer.masksToBounds=YES;
        [self addSubview:centerV];
        //
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 29)];
        lab1.text=@"我的创业";
        lab1.font=[UIFont systemFontOfSize:17];
        lab1.textColor=[UIColor colorWithHexString:@"#323232"];
        [centerV addSubview:lab1];
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(10, lab1.bottom, centerV.width-20, 1)];
        line1.backgroundColor=RGBAColor(238, 240, 242, 1);
        [centerV addSubview:line1];
        //
        NSArray *titleArr1=@[@"创意",@"项目",@"团队",@"资源"];
        NSArray *imageArray1=@[@"mine_creativity",@"mine_project",@"mine_team",@"mine_resource"];
        UIView *lastView1=nil;
        for (int i=0; i<4; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArray1[i]] forState:UIControlStateNormal];
            [btn setTitle:titleArr1[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:16];
            [btn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=800+i;
            [centerV addSubview:btn];
            //
            btn.sd_layout
            .leftSpaceToView(lastView1, 0)
            .topSpaceToView(line1, 0)
            .widthIs(centerV.width/4)
            .heightIs(65);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn, 10)
            .widthIs(25)
            .heightIs(25);
            btn.titleLabel.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn.imageView, 0)
            .widthIs(centerV.width/4)
            .heightIs(30);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            lastView1=btn;
        }
        
        //
        UIView *bottomV=[[UIView alloc]initWithFrame:CGRectMake(10, centerV.bottom+10, frame.size.width-20, 65)];
        bottomV.backgroundColor=[UIColor whiteColor];
        bottomV.layer.cornerRadius=5;
        bottomV.layer.masksToBounds=YES;
        [self addSubview:bottomV];
        //
        NSArray *titleArr2=@[@"我的收藏",@"我的发表",@"我的消息"];
        NSArray *imageArray2=@[@"mine_collect",@"mine_publish",@"mine_news"];
        UIView *lastView2=nil;
        for (int i=0; i<3; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArray2[i]] forState:UIControlStateNormal];
            [btn setTitle:titleArr2[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:16];
            [btn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=900+i;
            [bottomV addSubview:btn];
            
            //
            btn.sd_layout
            .leftSpaceToView(lastView2, 0)
            .topSpaceToView(bottomV, 0)
            .widthIs(bottomV.width/3)
            .heightIs(65);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn, 10)
            .widthIs(30)
            .heightIs(30);
            btn.titleLabel.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn.imageView, 0)
            .widthIs(bottomV.width/3)
            .heightIs(25);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            //
            if (i==2) {
                self.mesCountLab=[[UILabel alloc]init];
                self.mesCountLab.font=[UIFont systemFontOfSize:8];
                self.mesCountLab.backgroundColor=[UIColor redColor];
                self.mesCountLab.textColor=[UIColor whiteColor];
                self.mesCountLab.textAlignment=NSTextAlignmentCenter;
                self.mesCountLab.text=@"";
                [bottomV addSubview:self.mesCountLab];
                self.mesCountLab.sd_layout
                .topEqualToView(btn.imageView)
                .centerXIs(bottomV.width*5/6+15)
                .widthIs(12)
                .heightIs(12);
                self.mesCountLab.sd_cornerRadius=@(2);
            }
            
            lastView2=btn;
        }
        //
        
    }
    return self;
}
-(void)threeBtnClick:(UIButton *)btn{
    if (self.threeBtnClickBlock) {
        self.threeBtnClickBlock(btn.tag);
    }
}
-(void)fourBtnClick:(UIButton *)btn{
    if (self.fourBtnClickBlock) {
        self.fourBtnClickBlock(btn.tag);
    }
}
-(void)setClicked{
    if (self.setClickedBlock) {
        self.setClickedBlock();
    }
}
-(void)loginClick{
    if (self.loginClickBlock) {
        self.loginClickBlock();
    }
}
-(void)setHeaderClick{
    if (self.HeaderClickBlock) {
        self.HeaderClickBlock();
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
