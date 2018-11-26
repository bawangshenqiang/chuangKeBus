//
//  CreativityDetailBottomCommentView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CreativityDetailBottomCommentView.h"

@implementation CreativityDetailBottomCommentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kBackgroundColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
        //
        self.textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 15, frame.size.width-80-30-5, 30)];
        self.textView.delegate=self;
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
        self.praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.praiseBtn.frame=CGRectMake(self.textView.right+5, 15, 30, 30);
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap"] forState:UIControlStateNormal];
        [self.praiseBtn setImage:[UIImage imageNamed:@"project_snap_nor"] forState:UIControlStateSelected];
        [self.praiseBtn addTarget:self action:@selector(praiseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.praiseBtn];
        //
        self.sharedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sharedBtn.frame=CGRectMake(self.praiseBtn.right+20, 15, 30, 30);
        [self.sharedBtn setImage:[UIImage imageNamed:@"project_reposter"] forState:UIControlStateNormal];
        [self.sharedBtn addTarget:self action:@selector(sharedBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sharedBtn];
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
        self.submitBtn.hidden=YES;
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
-(void)praiseBtnClick{
    //self.praiseBtn.selected=!self.praiseBtn.isSelected;
    if (self.praiseBtnBlock) {
        self.praiseBtnBlock();
    }
}
-(void)sharedBtnClick{
    if (self.sharedBtnBlock) {
        self.sharedBtnBlock();
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.praiseBtn.hidden=YES;
    self.sharedBtn.hidden=YES;
    self.submitBtn.hidden=NO;
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.praiseBtn.hidden=NO;
    self.sharedBtn.hidden=NO;
    self.submitBtn.hidden=YES;
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
