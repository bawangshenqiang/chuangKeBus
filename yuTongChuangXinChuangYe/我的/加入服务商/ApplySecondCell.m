//
//  ApplySecondCell.m
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/15.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "ApplySecondCell.h"

@implementation ApplySecondCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 120, 15)];
        self.topLab.font=[UIFont systemFontOfSize:14];
        self.topLab.textColor=[UIColor colorWithHexString:@"#989898"];
        self.topLab.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.topLab];
        
        self.textField.backgroundColor=[UIColor whiteColor];
        self.showCountLab.hidden=YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    }
    return self;
}


-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textField endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(UITextField *)textField{
    if (!_textField) {
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(15, self.topLab.bottom+8, kScreenWidth-60, 19)];
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.font=[UIFont systemFontOfSize:16];
        _textField.textColor=[UIColor colorWithHexString:@"#323232"];
        [_textField setInputAccessoryView:[SJTool backToolBarView]];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}
-(UILabel *)showCountLab{
    if (!_showCountLab) {
        _showCountLab=[[UILabel alloc]initWithFrame:CGRectMake(self.textField.right, self.topLab.bottom+10, 30, 15)];
        _showCountLab.font=[UIFont systemFontOfSize:12];
        _showCountLab.textAlignment=NSTextAlignmentCenter;
        _showCountLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
        [self.contentView addSubview:_showCountLab];
    }
    return _showCountLab;
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
