//
//  AnimatTextFieldCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AnimatTextFieldCell.h"

@implementation AnimatTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 8, 100, 44)];
        self.topLab.font=[UIFont systemFontOfSize:17];
        self.topLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:self.topLab];
        //
        self.textField=[[UITextField alloc]initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 44)];
        self.textField.font=[UIFont systemFontOfSize:15];
        [self.textField setInputAccessoryView:[SJTool backToolBarView]];
        self.textField.delegate=self;
        [self.contentView addSubview:self.textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    }
    return self;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        self.topLab.textColor=kThemeColor;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topLab.frame=CGRectMake(15, 8, 100, 18);
            self.textField.frame=CGRectMake(15, self.topLab.bottom+8, kScreenWidth-30, 18);
            self.topLab.textColor=kThemeColor;
            self.topLab.font=[UIFont systemFontOfSize:12];
        }];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        self.topLab.textColor=[UIColor colorWithHexString:@"#989898"];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topLab.frame=CGRectMake(15, 8, 100, 44);
            self.textField.frame=CGRectMake(15, 8, kScreenWidth-30, 44);
            self.topLab.font=[UIFont systemFontOfSize:17];
            self.topLab.textColor=[UIColor colorWithHexString:@"#323232"];
        }];
    }
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textField endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
