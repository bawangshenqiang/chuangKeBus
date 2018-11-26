//
//  SystemMessageCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemMessageCell.h"

@implementation SystemMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.outBig];
        
        self.titleLab=[[UILabel alloc]init];
        self.titleLab.font=[UIFont systemFontOfSize:18];
        [self.outBig addSubview:self.titleLab];
        
        self.detailLab=[[UILabel alloc]init];
        self.detailLab.font=[UIFont systemFontOfSize:16];
        self.detailLab.textColor=[UIColor colorWithHexString:@"#323232"];
        self.detailLab.numberOfLines=2;
        [self.outBig addSubview:self.detailLab];
        
        self.timeLab=[[UILabel alloc]init];
        self.timeLab.font=[UIFont systemFontOfSize:14];
        self.timeLab.textAlignment=NSTextAlignmentRight;
        self.timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:self.timeLab];
        //
        _outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [_outBig setupAutoHeightWithBottomView:_timeLab bottomMargin:10];
        _outBig.sd_cornerRadius=@(5);
        
        _titleLab.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.outBig, 10)
        .widthIs(kScreenWidth-40)
        .heightIs(15);
        
        _detailLab.sd_layout
        .leftEqualToView(self.titleLab)
        .topSpaceToView(self.titleLab, 10)
        .widthRatioToView(self.titleLab, 1)
        .autoHeightRatio(0);
        [_detailLab setMaxNumberOfLinesToShow:2];
        
        _timeLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .topSpaceToView(self.detailLab, 10)
        .heightIs(15);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:140];
    }
    return self;
}
-(void)setModel:(SystemMessageModel *)model{
    _model=model;
    self.titleLab.text=_model.title;
    self.detailLab.text=_model.detail;
    self.timeLab.text=_model.create_time;
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
