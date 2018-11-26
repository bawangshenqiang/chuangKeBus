//
//  SetCell_switch.m
//  皮口袋记账
//
//  Created by 霸枪001 on 2018/6/15.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "SetCell_switch.h"

@implementation SetCell_switch
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 60)];
        [self.contentView addSubview:self.titleLab];
        //
        _rightSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-15-50, 15, 50, 30)];
        _rightSwitch.backgroundColor = [UIColor whiteColor];
        
        //设置开启状态的风格颜色
        [_rightSwitch setOnTintColor:kThemeColor];
        
        //设置开关圆按钮的风格颜色
        // [_rightSwitch setThumbTintColor:[UIColor blueColor]];
        
        //设置整体风格颜色,按钮的白色是整个父布局的背景颜色
        UIColor *tintColor = RGBAColor(189, 190, 191, 1);
        [_rightSwitch setTintColor:tintColor];
        [_rightSwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
        
        [self.contentView addSubview:_rightSwitch];
    }
    return self;
}
- (void)swChange:(UISwitch*)sw{
    
    if (self.switchBlock){
        self.switchBlock(_indexPath, sw.on);
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
