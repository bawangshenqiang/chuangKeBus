//
//  HotServeCell_ServeFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HotServeCell_ServeFirst.h"

@implementation HotServeCell_ServeFirst
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 115)];
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.outBig.layer.cornerRadius=5;
        self.outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:self.outBig];
        //
        UIView *lastView=nil;
        for (int i=0; i<2; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font=[UIFont systemFontOfSize:13];
            [btn setTitleColor:[UIColor colorWithHexString:@"#323232"] forState:UIControlStateNormal];
            btn.titleLabel.numberOfLines=2;
            
            [btn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=600+i;
            [self.outBig addSubview:btn];
            
            btn.sd_layout
            .leftSpaceToView(lastView, 10)
            .topSpaceToView(self.outBig, 10)
            .widthIs((self.outBig.width-30)/2)
            .heightIs(105);
            btn.imageView.sd_layout
            .centerXEqualToView(btn)
            .topEqualToView(btn)
            .widthRatioToView(btn, 1)
            .heightIs(75);
            btn.imageView.sd_cornerRadius=@(5);
            btn.titleLabel.sd_layout
            .leftEqualToView(btn)
            .topSpaceToView(btn.imageView, 0)
            .widthRatioToView(btn, 1)
            .heightIs(30);
            //.autoHeightRatio(0);
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            [btn.titleLabel setMaxNumberOfLinesToShow:2];
            
            lastView=btn;
        }
    }
    return self;
}
-(void)twoBtnClick:(UIButton *)btn{
    if (_models.count>0) {
        StarCourseModel_Serve *aModel=_models[btn.tag-600];
        if (self.ACellBtnClickBlock) {
            self.ACellBtnClickBlock(aModel.Id);
        }
    }
    
}
-(void)setModels:(NSMutableArray<StarCourseModel_Serve *> *)models{
    _models=models;
    if (_models.count>0) {
        for (int i=0; i<2; i++) {
            UIView *view=self.outBig.subviews[i];
            StarCourseModel_Serve *aModel=_models[i];
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn=(UIButton *)view;
                [btn setTitle:aModel.title forState:UIControlStateNormal];
                [btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aModel.picture]]] forState:UIControlStateNormal];
            }
        }
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
