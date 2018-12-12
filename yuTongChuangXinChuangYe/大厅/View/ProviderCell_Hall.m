//
//  ProviderCell_Hall.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/10.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProviderCell_Hall.h"

@implementation ProviderCell_Hall

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
        self.scrollView.showsHorizontalScrollIndicator=NO;
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}
-(void)setProviderData:(NSMutableArray *)providerData{
    _providerData=providerData;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (providerData.count>0) {
        for (int i=0; i<_providerData.count; i++) {
            
            StarCourseModel_Serve *model=_providerData[i];
            
            UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(12+114*i, 0, 104, 130)];
            bgView.backgroundColor=[UIColor whiteColor];
            [self.scrollView addSubview:bgView];
            
            UIImageView *topIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 80, 40)];
            [topIV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"entrepreneurship"]];
            topIV.layer.borderWidth=0.5;
            topIV.layer.borderColor=RGBAColor(165, 165, 165, 0.5).CGColor;
            [bgView addSubview:topIV];
            //
            UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(12, topIV.bottom+10, 80, 15)];
            title.text=model.title;
            title.font=[UIFont systemFontOfSize:14];
            title.textColor=RGBAColor(51, 51, 51, 1);
            [bgView addSubview:title];
            //
            UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(12, title.bottom+10, 80, 25)];
            detail.numberOfLines=2;
            detail.text=model.descripetions;
            detail.font=[UIFont systemFontOfSize:9];
            detail.textColor=RGBAColor(102, 102, 102, 1);
            [bgView addSubview:detail];
            //
            //
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(12+114*i, 0, 104, 130);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=2100+i;
            [self.scrollView addSubview:btn];
        }
        
        self.scrollView.contentSize=CGSizeMake(12+104*_providerData.count+10*(_providerData.count-1)+12, 130);
    }
}
-(void)btnClick:(UIButton *)btn{
    StarCourseModel_Serve *model=_providerData[btn.tag-2100];
    if (self.btnClickBlock) {
        self.btnClickBlock(model.Id);
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
