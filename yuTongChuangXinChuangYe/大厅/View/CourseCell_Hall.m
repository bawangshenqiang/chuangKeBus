//
//  CourseCell_Hall.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/10.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CourseCell_Hall.h"


@implementation CourseCell_Hall

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        self.scrollView.showsHorizontalScrollIndicator=NO;
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}
- (void)setCourseData:(NSMutableArray *)courseData{
    _courseData=courseData;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (courseData.count>0) {
        for (int i=0; i<_courseData.count; i++) {
            StarCourseModel_Serve *model=_courseData[i];
            
            UIView *bgiew=[[UIView alloc]initWithFrame:CGRectMake(12+125*i, 0, 110, 150)];
            bgiew.backgroundColor=[UIColor whiteColor];
            [self.scrollView addSubview:bgiew];
            //
            UIImageView *topIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 110, 70)];
            [topIV sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"picture"]];
            [bgiew addSubview:topIV];
            //
            UILabel *study=[[UILabel alloc]initWithFrame:CGRectMake(0, topIV.bottom+10, 110, 15)];
            study.text=[NSString stringWithFormat:@"%d人学过",model.views];
            study.font=[UIFont systemFontOfSize:13];
            study.textColor=RGBAColor(102, 102, 102, 1);
            [bgiew addSubview:study];
            //
            UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, study.bottom+10, 110, 15)];
            title.text=model.title;
            title.font=[UIFont systemFontOfSize:15];
            title.textColor=RGBAColor(51, 51, 51, 1);
            [bgiew addSubview:title];
            //
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(12+125*i, 0, 110, 150);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=2000+i;
            [self.scrollView addSubview:btn];
        }
        
        self.scrollView.contentSize=CGSizeMake(12+110*_courseData.count+15*(_courseData.count-1)+12, 150);
    }
    
}
-(void)btnClick:(UIButton *)btn{
    StarCourseModel_Serve *model=_courseData[btn.tag-2000];
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
