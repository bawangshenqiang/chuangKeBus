//
//  TableHeader_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TableHeader_HallFirst.h"

@implementation TableHeader_HallFirst
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        //
        NSArray *imageArr=@[@"图片3.jpg",@"图片3.jpg",@"图片3.jpg",@"图片3.jpg"];
        self.cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, frame.size.width, 145*kBaseHeight) imageNamesGroup:imageArr];
        //self.cycleScrollView.pageControlBottomOffset=15*kBaseHeight;
        [self addSubview:self.cycleScrollView];
        //
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, frame.size.width, 90*kBaseHeight)];//CGRectMake(10, self.cycleScrollView.bottom-15*kBaseHeight, frame.size.width-20, 100*kBaseHeight)
        bottomView.backgroundColor=[UIColor whiteColor];
        //bottomView.layer.cornerRadius=5;
        //bottomView.layer.masksToBounds=YES;
        [self addSubview:bottomView];
        //
        NSArray *titleArr=@[@"创意吧",@"项目库",@"找伙伴"];
        NSArray *imageArray=@[@"hall_creativity",@"hall_project",@"hall_partner"];
        UIView *lastView=nil;
        for (int i=0; i<3; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i;
            [bottomView addSubview:btn];
            //
            btn.sd_layout
            .leftSpaceToView(lastView, 0)
            .topEqualToView(bottomView)
            .widthIs(bottomView.width/3)
            .heightIs(bottomView.height);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn, 13*kBaseHeight)
            .widthIs(45*kBaseHeight)
            .heightIs(45*kBaseHeight);
            btn.titleLabel.sd_layout
            .centerXEqualToView(btn)
            .topSpaceToView(btn.imageView, 8*kBaseHeight)
            .widthIs(bottomView.width/3)
            .bottomSpaceToView(btn, 13*kBaseHeight);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
            lastView=btn;
        }
    }
    return self;
}
-(void)threeBtnClick:(UIButton *)btn{
    if (self.threeBtnClickBlock) {
        self.threeBtnClickBlock(btn.tag);
    }
}
-(void)setCycleImageUrls:(NSArray *)cycleImageUrls{
    _cycleImageUrls=cycleImageUrls;
    self.cycleScrollView.imageURLStringsGroup=cycleImageUrls;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
