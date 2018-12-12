//
//  CommentSubmitViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentSubmitViewController.h"

@interface CommentSubmitViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@end

@implementation CommentSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"写评论";
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(commitClick)];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    //
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight)];
    self.textView.delegate=self;
    self.textView.font=[UIFont systemFontOfSize:16];
    self.textView.textColor=[UIColor colorWithHexString:@"#989898"];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"欢迎参与交流，有什么想法写下来吧~";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:16];
    [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [self.textView setInputAccessoryView:[SJTool backToolBarView]];
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
}
-(void)cancleClick{
    [self.textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)commitClick{
    if (!self.textView.text.length) {
        [SJTool showAlertWithText:@"评论不能为空"];
        return;
    }
    
    if (self.submitBtnBlock) {
        self.submitBtnBlock(self.textView.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}
-(void)dismissKeyboard:(NSNotification *)noti{
    [self.textView endEditing:YES];
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
