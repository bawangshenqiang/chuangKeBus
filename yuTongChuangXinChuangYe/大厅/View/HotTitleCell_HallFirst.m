//
//  HotTitleCell_HallFirst.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HotTitleCell_HallFirst.h"

@implementation HotTitleCell_HallFirst
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headTitles=[NSMutableArray array];
        self.titleLabs=[NSMutableArray array];
        //
        UIView *outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 210)];
        outBig.backgroundColor=[UIColor whiteColor];
        outBig.layer.cornerRadius=5;
        outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:outBig];
        //
        //NSArray *leftTitles=@[@"活动",@"课程",@"资讯"];
        //NSArray *rightTitles=@[@"宇通供应链创业分享会，7月25日不见不散！",@"俞敏洪——我的创业之路！",@"宇通供应链创业分享会，7月25日不见不散！"];
        for (int i=0; i<6; i++) {
            UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 8+35*i, 35, 19)];
            //leftLab.text=leftTitles[i];
            leftLab.textColor=[UIColor colorWithHexString:@"ff983e"];
            leftLab.font=[UIFont systemFontOfSize:15];
            leftLab.textAlignment=NSTextAlignmentCenter;
            leftLab.layer.borderWidth=0.5;
            leftLab.layer.borderColor=[UIColor colorWithHexString:@"ff983e"].CGColor;
            [outBig addSubview:leftLab];
            [self.headTitles addObject:leftLab];
            //
            UILabel *rightLab=[[UILabel alloc]initWithFrame:CGRectMake(leftLab.right+5, 35*i, outBig.width-leftLab.right-10, 35)];
            rightLab.font=[UIFont systemFontOfSize:16];
            //rightLab.text=rightTitles[i];
            rightLab.tag=200+i;
            [outBig addSubview:rightLab];
            [self.titleLabs addObject:rightLab];
            rightLab.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectACell:)];
            [rightLab addGestureRecognizer:tap];
            //
            if (i!=5) {
                UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, rightLab.bottom-0.5, outBig.width-20, 0.5)];
                line.backgroundColor=RGBAColor(145, 165, 165, 0.5);
                [outBig addSubview:line];
            }
        }
        
    }
    return self;
}
-(void)setModels:(NSArray<Hall_HomeTodayHotModel *> *)models{
    _models=models;
    if (_models.count==self.headTitles.count) {
        for (int i=0; i<self.headTitles.count; i++) {
            UILabel *labLeft=self.headTitles[i];
            UILabel *labRight=self.titleLabs[i];
            Hall_HomeTodayHotModel *model=_models[i];
            labLeft.text=model.modulename;
            labRight.text=model.title;
        }
    }
}
-(void)selectACell:(UITapGestureRecognizer *)tap{
    if (_models.count==self.headTitles.count) {
        if (self.TitleClickBlock) {
            self.TitleClickBlock(_models[tap.view.tag-200]);
        }
        NSLog(@"tag:%ld",(long)tap.view.tag);
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
