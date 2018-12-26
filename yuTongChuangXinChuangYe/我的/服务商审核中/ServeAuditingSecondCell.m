//
//  ServeAuditingSecondCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeAuditingSecondCell.h"

@implementation ServeAuditingSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 90)];
        self.bigView.backgroundColor=[UIColor whiteColor];
        self.bigView.layer.cornerRadius=4;
        [self.contentView addSubview:self.bigView];
        //
        UILabel *colorLab=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, 5, 20)];
        colorLab.backgroundColor=RGBAColor(255, 150, 0, 1);
        [self.bigView addSubview:colorLab];
        //
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(colorLab.right+12, 15, 100, 20)];
        self.topLab.text=@"审核状态";
        self.topLab.font=[UIFont systemFontOfSize:16];
        self.topLab.textColor=RGBAColor(51, 51, 51, 1);
        [self.bigView addSubview:self.topLab];
        //
        self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(colorLab.right+12, 90-20-14, 120, 14)];
        self.contentLab.text=@"审核中";
        self.contentLab.font=[UIFont systemFontOfSize:14];
        self.contentLab.textColor=RGBAColor(255, 150, 0, 1);
        [self.bigView addSubview:self.contentLab];
    }
    return self;
}
-(void)setModel:(JoinServerModel *)model{
    _model=model;
    if (_model.status==2) {
        self.contentLab.text=@"未通过";
    }else{
        self.contentLab.text=@"审核中";
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
