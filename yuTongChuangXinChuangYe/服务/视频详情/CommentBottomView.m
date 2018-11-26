//
//  CommentBottomView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentBottomView.h"

@implementation CommentBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
        //
        self.textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 15, frame.size.width-80-30-5, 30)];
        self.textView.font=[UIFont systemFontOfSize:14];
        self.textView.textColor=[UIColor colorWithHexString:@"#989898"];
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"写评论";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        [placeHolderLabel sizeToFit];
        [self.textView addSubview:placeHolderLabel];
        placeHolderLabel.font = [UIFont systemFontOfSize:14];
        [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        [self.textView setInputAccessoryView:[SJTool backToolBarView]];
        self.textView.backgroundColor=[UIColor whiteColor];
        self.textView.layer.cornerRadius=5;
        self.textView.layer.borderWidth=0.5;
        self.textView.layer.borderColor=[UIColor colorWithHexString:@"#cccccc"].CGColor;
        self.textView.layer.masksToBounds=YES;
        [self addSubview:self.textView];
        //
        self.submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.submitBtn.frame=CGRectMake(self.textView.right+5, 15, 80, 30);
        [self.submitBtn setTitle:@"发表" forState:UIControlStateNormal];
        [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.submitBtn.backgroundColor=kThemeColor;
        self.submitBtn.layer.cornerRadius=5;
        self.submitBtn.layer.masksToBounds=YES;
        [self.submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.submitBtn];
    }
    
    return self;
}
-(void)submitClick{
    if (!self.textView.text.length) {
        [SJTool showAlertWithText:@"评论不能为空"];
        return;
    }
    if (self.submitBtnBlock) {
        self.submitBtnBlock(self.textView.text);
    }
    [self.textView endEditing:YES];
    self.textView.text=@"";
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textView endEditing:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
