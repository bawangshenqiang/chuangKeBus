//
//  IntroduceCell_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "IntroduceCell_video.h"

@implementation IntroduceCell_video
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 15)];
        self.titleLab.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.titleLab];
        //
        self.titleLab.text=@"这家公司要用设计+AI创造新时代！";
        [self.flagBtn setTitle:@"新时代" forState:UIControlStateNormal];
        self.studyLab.text=@"314162人学过";
    }
    return self;
}
-(UIButton *)flagBtn{
    if (!_flagBtn) {
        _flagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_flagBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        _flagBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _flagBtn.layer.borderColor=kThemeColor.CGColor;
        _flagBtn.layer.borderWidth=0.5;
        [self.contentView addSubview:_flagBtn];
        
        _flagBtn.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.titleLab, 10);
        [_flagBtn setupAutoSizeWithHorizontalPadding:5 buttonHeight:15];
    }
    return _flagBtn;
}
-(UILabel *)studyLab{
    if (!_studyLab) {
        _studyLab=[[UILabel alloc]init];
        _studyLab.font=[UIFont systemFontOfSize:12];
        _studyLab.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_studyLab];
        _studyLab.sd_layout
        .leftSpaceToView(self.flagBtn, 10)
        .topEqualToView(self.flagBtn)
        .heightIs(15);
        [_studyLab setSingleLineAutoResizeWithMaxWidth:150];
    }
    return _studyLab;
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
