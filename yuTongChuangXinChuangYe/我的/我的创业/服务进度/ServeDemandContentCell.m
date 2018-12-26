//
//  ServeDemandContentCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeDemandContentCell.h"

@implementation ServeDemandContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *demand=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 100, 15)];
        demand.text=@"服务需求";
        demand.font=[UIFont systemFontOfSize:16];
        demand.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:demand];
        //
        self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-112, 15, 100, 15)];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.font=[UIFont systemFontOfSize:12];
        self.timeLab.textColor=RGBAColor(102, 102, 102, 1);
        [self.contentView addSubview:self.timeLab];
        //
        self.contentLab=[[UILabel alloc]init];
        self.contentLab.font=[UIFont systemFontOfSize:14];
        self.contentLab.numberOfLines=0;
        self.contentLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.contentLab];
        //
        self.contentLab.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(demand, 20)
        .rightSpaceToView(self.contentView, 12)
        .autoHeightRatio(0);
        
    }
    return self;
}
-(void)setModel:(ServeProgressModel *)model{
    _model=model;
    self.timeLab.text=_model.create_time;
    self.contentLab.text=_model.demand;
    [self setupAutoHeightWithBottomView:self.contentLab bottomMargin:20];
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
