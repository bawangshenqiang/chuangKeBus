//
//  SystemHallSecondCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemHallSecondCell.h"

@implementation SystemHallSecondCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 30, 15)];
        self.leftLab.text=@"置顶";
        self.leftLab.textColor=[UIColor whiteColor];
        self.leftLab.font=[UIFont systemFontOfSize:12];
        self.leftLab.textAlignment=NSTextAlignmentCenter;
        self.leftLab.backgroundColor=[UIColor colorWithHexString:@"#ffa800"];
        self.leftLab.layer.cornerRadius=7.5;
        self.leftLab.layer.masksToBounds=YES;
        [self.contentView addSubview:self.leftLab];
        //
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.leftLab.right+10, 0, kScreenWidth-70, 45)];
        self.titleLab.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLab];
        //
//        self.line=[[UIView alloc]initWithFrame:CGRectMake(10, 44.5, kScreenWidth-20, 0.5)];
//        self.line.backgroundColor=RGBAColor(165, 165, 165, 0.5);
//        [self.contentView addSubview:self.line];
    }
    return self;
}
-(void)setModelDic:(NSDictionary *)modelDic{
    _modelDic=modelDic;
    self.titleLab.text=_modelDic[@"title"];
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
