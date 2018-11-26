//
//  InterestCell_Public.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InterestCell_Public.h"

@implementation InterestCell_Public

-(void)setModel:(InterestModel_Public *)model{
    _model=model;
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.nameLab.text=_model.nickname;
    
    self.titleLab.text=_model.title;
    
    self.timeLab.text=_model.create_time;
    
    
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:10];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.outBig];
        //
        _leftLab=[[UILabel alloc]init];
        _leftLab.text=@"对";
        _leftLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_leftLab];
        //
        _headIV=[[UIImageView alloc]init];
        [self.outBig addSubview:_headIV];
        //
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16];
        _nameLab.textColor=kThemeColor;
        [self.outBig addSubview:_nameLab];
        //
        _rightLab=[[UILabel alloc]init];
        _rightLab.text=@"发表的找伙伴感兴趣";
        _rightLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_rightLab];
        //
        _titleView=[[UIView alloc]init];
        _titleView.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
        [self.outBig addSubview:_titleView];
        //
        _titleLab=[[UILabel alloc]init];
        _titleLab.font=[UIFont systemFontOfSize:14];
        _titleLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _titleLab.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
        _titleLab.numberOfLines=0;
        [_titleView addSubview:_titleLab];
        //
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:10];
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _timeLab.textAlignment=NSTextAlignmentRight;
        [self.outBig addSubview:_timeLab];
        
        _outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [_outBig setupAutoHeightWithBottomView:_timeLab bottomMargin:0];
        _outBig.sd_cornerRadius=@(5);
        
        _leftLab.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.outBig, 10)
        .heightIs(15);
        [_leftLab setSingleLineAutoResizeWithMaxWidth:50];
        
        _headIV.sd_layout
        .leftSpaceToView(self.leftLab, 10)
        .centerYEqualToView(self.leftLab)
        .widthIs(24)
        .heightIs(24);
        _headIV.sd_cornerRadius=@(12);
        
        _nameLab.sd_layout
        .leftSpaceToView(self.headIV, 10)
        .centerYEqualToView(self.headIV)
        .heightIs(15);
        [_nameLab setSingleLineAutoResizeWithMaxWidth:120];
        
        _rightLab.sd_layout
        .leftSpaceToView(self.nameLab, 10)
        .centerYEqualToView(self.headIV)
        .heightIs(15)
        .widthIs(kScreenWidth-20-self.nameLab.right-20);
        
        _titleView.sd_layout
        .leftEqualToView(self.leftLab)
        .topSpaceToView(self.headIV, 5)
        .widthIs(kScreenWidth-40);
        [_titleView setupAutoHeightWithBottomView:_titleLab bottomMargin:10];
        _titleView.sd_cornerRadius=@(5);
        
        _titleLab.sd_layout
        .leftSpaceToView(self.titleView, 10)
        .topSpaceToView(self.titleView, 10)
        .widthIs(kScreenWidth-60)
        .autoHeightRatio(0);
        
        _timeLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .topSpaceToView(self.titleView, 0)
        .heightIs(20);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    return self;
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
