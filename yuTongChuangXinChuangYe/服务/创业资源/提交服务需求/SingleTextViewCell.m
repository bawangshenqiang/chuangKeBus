//
//  SingleTextViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SingleTextViewCell.h"

@implementation SingleTextViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textView.backgroundColor=kBackgroundColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    }
    return self;
}
-(UITextView *)textView{
    if (_textView==nil) {
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 80)];
        _textView.font=[UIFont systemFontOfSize:14];
        _textView.textColor=[UIColor grayColor];
        
        self.placeHolderLabel = [[UILabel alloc] init];
        
        self.placeHolderLabel.numberOfLines = 0;
        self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        [self.placeHolderLabel sizeToFit];
        [_textView addSubview:self.placeHolderLabel];
        self.placeHolderLabel.font = [UIFont systemFontOfSize:14];
        //kvc改变私有属性
        [_textView setValue:self.placeHolderLabel forKey:@"_placeholderLabel"];
        
        [_textView setInputAccessoryView:[SJTool backToolBarView]];
        
        _textView.layer.borderWidth=0.5;
        _textView.layer.borderColor=RGBAColor(165, 165, 145, 0.5).CGColor;
        _textView.layer.cornerRadius=4;
        _textView.layer.masksToBounds=YES;
        
        [self.contentView addSubview:_textView];
    }
    return _textView;
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textView endEditing:YES];
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
