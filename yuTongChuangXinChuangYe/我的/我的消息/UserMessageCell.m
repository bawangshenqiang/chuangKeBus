//
//  UserMessageCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "UserMessageCell.h"

@implementation UserMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.outBig];
        
        self.headIV=[[UIImageView alloc]init];
        [self.outBig addSubview:self.headIV];
        
        self.nameLab=[[UILabel alloc]init];
        self.nameLab.font=[UIFont systemFontOfSize:15];
        self.nameLab.textColor=kThemeColor;
        [self.outBig addSubview:self.nameLab];
        
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.font=[UIFont systemFontOfSize:10];
        self.timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:self.timeLab];
        
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:self.titleLab];
        
        
        //
        _outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [_outBig setupAutoHeightWithBottomView:_titleLab bottomMargin:15];
        _outBig.sd_cornerRadius=@(5);
        
        _headIV.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.outBig, 15)
        .widthIs(30)
        .heightIs(30);
        _headIV.sd_cornerRadius=@(15);
        
        _nameLab.sd_layout
        .leftSpaceToView(self.headIV, 10)
        .topEqualToView(self.headIV)
        .widthIs(kScreenWidth-20-self.headIV.right-20)
        .heightIs(14);
        
        _timeLab.sd_layout
        .leftSpaceToView(self.headIV, 10)
        .topSpaceToView(self.nameLab, 5)
        .heightIs(10);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:140];
        
        _titleLab.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.headIV, 10)
        .widthIs(kScreenWidth-40)
        .heightIs(15);
        
        
        
    }
    return self;
}
-(void)setModel:(UserMessageModel *)model{
    _model=model;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.nickname;
    self.timeLab.text=_model.create_time;
    self.titleLab.text=_model.title;
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:10];
    
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
