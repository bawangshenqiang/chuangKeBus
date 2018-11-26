//
//  AddSinglePhotoCell.m
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/2.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "AddSinglePhotoCell.h"

@implementation AddSinglePhotoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.topLab];
        [self.contentView addSubview:self.currentIma];
        
    }
    return self;
}
-(void)setImageUrl:(NSString *)imageUrl{
    
    [self.currentIma sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"tianjiatupian"]];
}
-(UILabel *)topLab{
    if (!_topLab) {
        _topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 15)];
        _topLab.font=[UIFont systemFontOfSize:14];
        _topLab.textColor=[UIColor colorWithHexString:@"#989898"];
        
    }
    return _topLab;
}
-(UIImageView *)currentIma{
    if (!_currentIma) {
        _currentIma=[[UIImageView alloc]initWithFrame:CGRectMake(15, self.topLab.bottom+10, 80, 60)];
        self.currentIma.backgroundColor=[UIColor whiteColor];
        _currentIma.image=[UIImage imageNamed:@"tianjiatupian"];
        _currentIma.userInteractionEnabled=YES;
        _currentIma.layer.cornerRadius=5;
        _currentIma.layer.masksToBounds=YES;
        [_currentIma setClipsToBounds:YES];
        _currentIma.contentMode=UIViewContentModeScaleAspectFill;
        
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick1:)];
        [_currentIma addGestureRecognizer:tap];
    }
    return _currentIma;
}
-(void)tapClick1:(UITapGestureRecognizer *)tapGesture{
    
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
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
