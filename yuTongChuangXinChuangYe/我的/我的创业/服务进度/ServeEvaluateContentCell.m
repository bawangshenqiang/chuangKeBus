//
//  ServeEvaluateContentCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeEvaluateContentCell.h"

@implementation ServeEvaluateContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *demand=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 100, 15)];
        demand.text=@"评价";
        demand.font=[UIFont systemFontOfSize:16];
        demand.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:demand];
        //
        self.ratingBar=[[RatingBar alloc]init];
        self.ratingBar.frame=CGRectMake(kScreenWidth-105, 15, 93, 16);
        self.ratingBar.isIndicator = YES;//指示器，就不能滑动了，只显示评分结果
        [self.ratingBar setImageDeselected:@"evaluate_star" halfSelected:nil fullSelected:@"evaluate_star_nor" andDelegate:nil];
        [self.contentView addSubview:self.ratingBar];
        //
        self.contentLab=[[UILabel alloc]init];
        self.contentLab.font=[UIFont systemFontOfSize:14];
        self.contentLab.numberOfLines=0;
        self.contentLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.contentLab];
        //
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.font=[UIFont systemFontOfSize:12];
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:self.timeLab];
        //
        self.contentLab.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(demand, 20)
        .rightSpaceToView(self.contentView, 12)
        .autoHeightRatio(0);
        //
        self.timeLab.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentLab, 12)
        .widthIs(120)
        .heightIs(14);
    }
    return self;
}
-(void)setModel:(ServeProgressModel *)model{
    _model=model;
    [self.ratingBar displayRating:(float)_model.star];
    self.contentLab.text=_model.comment;
    self.timeLab.text=_model.comment_time;
    [self setupAutoHeightWithBottomView:self.timeLab bottomMargin:15];
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
