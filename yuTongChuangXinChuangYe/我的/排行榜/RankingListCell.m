//
//  RankingListCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "RankingListCell.h"

@implementation RankingListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 40, 40)];
        self.leftIV.layer.cornerRadius=20;
        self.leftIV.layer.masksToBounds=YES;
        [self.contentView addSubview:self.leftIV];
        //
        self.name=[[UILabel alloc]initWithFrame:CGRectMake(self.leftIV.right+15, 15, 150, 15)];
        self.name.font=[UIFont systemFontOfSize:16];
        self.name.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.name];
        //
        self.leiJi=[[UILabel alloc]init];
        self.leiJi.text=@"累计获得车票";
        self.leiJi.font=[UIFont systemFontOfSize:14];
        self.leiJi.textColor=RGBAColor(153, 153, 153, 1);
        [self.contentView addSubview:self.leiJi];
        //
        self.ticketLab=[[UILabel alloc]init];
        self.ticketLab.font=[UIFont systemFontOfSize:14];
        self.ticketLab.textColor=RGBAColor(255, 150, 0, 1);
        [self.contentView addSubview:self.ticketLab];
        //
        self.medalIV=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-14-24, (70-19)/2, 14, 19)];
        self.medalIV.hidden=YES;
        [self.contentView addSubview:self.medalIV];
        //
        self.rangingLab=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-14-24, (70-19)/2, 14, 19)];
        self.rangingLab.textAlignment=NSTextAlignmentCenter;
        self.rangingLab.font=[UIFont systemFontOfSize:14];
        self.rangingLab.textColor=RGBAColor(102, 102, 102, 1);
        self.rangingLab.hidden=YES;
        [self.contentView addSubview:self.rangingLab];
        //
        self.leiJi.sd_layout
        .leftSpaceToView(self.leftIV, 15)
        .topSpaceToView(self.name, 10)
        .heightIs(15);
        [self.leiJi setSingleLineAutoResizeWithMaxWidth:120];
        //
        self.ticketLab.sd_layout
        .leftSpaceToView(self.leiJi, 5)
        .centerYEqualToView(self.leiJi)
        .heightIs(15);
        [self.ticketLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return self;
}
-(void)setModel:(RankingListModel *)model{
    _model=model;
    
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
