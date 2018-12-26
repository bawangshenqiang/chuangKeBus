//
//  TaskCenterCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TaskCenterCell.h"

@implementation TaskCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        self.leftIV=[[UIImageView alloc]init];
        [self.contentView addSubview:self.leftIV];
        //
        self.topTitle=[[UILabel alloc]init];
        self.topTitle.font=[UIFont systemFontOfSize:16];
        self.topTitle.textColor=RGBAColor(51, 51, 51, 1);
        [self.contentView addSubview:self.topTitle];
        //
        self.topScore=[[UILabel alloc]init];
        self.topScore.font=[UIFont systemFontOfSize:14];
        self.topScore.textColor=RGBAColor(255, 150, 0, 1);
        [self.contentView addSubview:self.topScore];
        //
        self.bottomTitle=[[UILabel alloc]init];
        self.bottomTitle.font=[UIFont systemFontOfSize:14];
        self.bottomTitle.textColor=RGBAColor(153, 153, 153, 1);
        [self.contentView addSubview:self.bottomTitle];
        //
        self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.btn.hidden=YES;
        [self.contentView addSubview:self.btn];
        //
        self.completeLab=[[UILabel alloc]init];
        self.completeLab.textAlignment=NSTextAlignmentRight;
        self.completeLab.font=[UIFont systemFontOfSize:14];
        self.completeLab.textColor=RGBAColor(255, 150, 0, 1);
        self.completeLab.hidden=YES;
        [self.contentView addSubview:self.completeLab];
        //
        self.leftIV.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 15)
        .widthIs(40)
        .heightIs(40);
        //
        self.topTitle.sd_layout
        .leftSpaceToView(self.leftIV, 15)
        .topSpaceToView(self.contentView, 16)
        .heightIs(14);
        [self.topTitle setSingleLineAutoResizeWithMaxWidth:120];
        //
        self.topScore.sd_layout
        .leftSpaceToView(self.topTitle, 5)
        .topEqualToView(self.topTitle)
        .heightIs(14);
        [self.topScore setSingleLineAutoResizeWithMaxWidth:80];
        //
        self.bottomTitle.sd_layout
        .leftEqualToView(self.topTitle)
        .topSpaceToView(self.topTitle, 10)
        .heightIs(14);
        [self.bottomTitle setSingleLineAutoResizeWithMaxWidth:kScreenWidth-12-40-15-12-60-15];
        //
        self.btn.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(60)
        .heightIs(24);
        self.btn.sd_cornerRadius=@(12);
        //
        self.completeLab.sd_layout
        .rightSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .heightIs(14);
        [self.completeLab setSingleLineAutoResizeWithMaxWidth:100];
    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.titleLabel.text,self.indexPath);
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
