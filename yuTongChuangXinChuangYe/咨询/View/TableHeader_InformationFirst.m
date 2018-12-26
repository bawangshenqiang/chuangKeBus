//
//  TableHeader_InformationFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TableHeader_InformationFirst.h"

@implementation TableHeader_InformationFirst

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        //
        self.topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 145*kBaseHeight)];
        self.topIV.image=[UIImage imageNamed:@"information_banner"];
        self.topIV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topImageClick)];
        [self.topIV addGestureRecognizer:tap];
        [self addSubview:self.topIV];
        //
        self.hot_24=[[Hot_24 alloc]initWithFrame:CGRectMake(10, self.topIV.bottom-15*kBaseHeight, kScreenWidth-20, 140*kBaseHeight)];
        self.hot_24.layer.cornerRadius=5;
        [self addSubview:self.hot_24];
        //
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(10, self.hot_24.bottom+15*kBaseHeight, frame.size.width-20, 85*kBaseHeight)];
        bottomView.backgroundColor=[UIColor whiteColor];
        bottomView.layer.cornerRadius=5;
        bottomView.layer.masksToBounds=YES;
        [self addSubview:bottomView];
        //
        //
        NSArray *titleArr=@[@"行业热点",@"最新政策",@"创新宇通",@"7✕24快讯"];
        NSArray *imageArray=@[@"information_industry",@"information_policy",@"information_yutong",@"information_newsflash"];
        UIView *lastView=nil;
        for (int i=0; i<4; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=100+i;
            [bottomView addSubview:btn];
            //
            btn.sd_layout
            .leftSpaceToView(lastView, 0)
            .topEqualToView(bottomView)
            .widthIs(bottomView.width/4)
            .heightIs(bottomView.height);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn, 10*kBaseHeight)
            .widthIs(45*kBaseHeight)
            .heightIs(45*kBaseHeight);
            btn.titleLabel.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn.imageView, 0)
            .widthIs(bottomView.width/4)
            .heightIs(30*kBaseHeight);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            lastView=btn;
        }
    }
    return self;
}
-(void)setTopImage:(NSDictionary *)topImage{
    _topImage=topImage;
    [self.topIV sd_setImageWithURL:[NSURL URLWithString:_topImage[@"cover"]] placeholderImage:[UIImage imageNamed:@"information_banner"]];
}
-(void)topImageClick{
    if (self.topImageClickBlock) {
        self.topImageClickBlock(_topImage);
    }
}
-(void)fourBtnClick:(UIButton *)btn{
    if (self.fourBtnClickBlock) {
        self.fourBtnClickBlock(btn.tag-100);
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
