//
//  SingleTextFieldCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SingleTextFieldCell.h"

@implementation SingleTextFieldCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-60, self.height)];
        //_textField.textAlignment=NSTextAlignmentRight;
        _textField.font=[UIFont systemFontOfSize:15];
        [_textField setInputAccessoryView:[SJTool backToolBarView]];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}
-(UILabel *)showCountLab{
    if (!_showCountLab) {
        _showCountLab=[[UILabel alloc]initWithFrame:CGRectMake(self.textField.right, 0, 30, self.height)];
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
