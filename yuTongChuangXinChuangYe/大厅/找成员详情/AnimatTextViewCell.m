//
//  AnimatTextViewCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AnimatTextViewCell.h"
#import "CaredMemberViewController.h"

@implementation AnimatTextViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //
        self.textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 44)];
        self.textView.font=[UIFont systemFontOfSize:15];
        [self.textView setInputAccessoryView:[SJTool backToolBarView]];
        self.textView.delegate=self;
        //不要自动联想修正
        self.textView.autocorrectionType=UITextAutocorrectionTypeNo;
        //控制晃动
        self.textView.scrollEnabled=NO;
        self.textView.layoutManager.allowsNonContiguousLayout = NO;
        
        [self.contentView addSubview:self.textView];
        
        
        self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 8, 100, 44)];
        self.topLab.font=[UIFont systemFontOfSize:17];
        self.topLab.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.contentView addSubview:self.topLab];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    }
    return self;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        self.topLab.textColor=kThemeColor;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topLab.frame=CGRectMake(15, 8, 100, 18);
            self.textView.frame=CGRectMake(15, self.topLab.bottom, kScreenWidth-30, 34);
            self.topLab.textColor=kThemeColor;
            self.topLab.font=[UIFont systemFontOfSize:12];
        }];
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        self.topLab.textColor=[UIColor colorWithHexString:@"#989898"];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topLab.frame=CGRectMake(15, 8, 100, 44);
            self.textView.frame=CGRectMake(15, 8, kScreenWidth-30, 44);
            self.topLab.font=[UIFont systemFontOfSize:17];
            self.topLab.textColor=[UIColor colorWithHexString:@"#323232"];
        }];
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    
    _model.contents = textView.text;
    
    //计算高度
    
    //    CGSize constraintSize =CGSizeMake(kScreenWidth -60, MAXFLOAT);
    //
    //    CGSize size = [textView sizeThatFits:constraintSize];
    //
    //    CGRect newRect=textView.frame;
    //    newRect.size=CGSizeMake(kScreenWidth -60, size.height);
    //    textView.frame=newRect;
    
    CGSize size = [self getStringRectInTextView:textView.text InTextView:textView];
    
    CGRect frame = textView.frame;
    frame.size.height = size.height;
    textView.frame = frame;
    
    
    [textView scrollRangeToVisible:NSMakeRange(0,0)];
    
    if (size.height<34) {
        _model.cellHeight=60;
    }else{
        _model.cellHeight = size.height+26;
    }
    if (textView.text.length<=0) {
        _model.cellHeight=60;
    }
    
    //刷新cell
    CaredMemberViewController *viewC=(CaredMemberViewController *)[self viewController];
    
    [viewC.tableView beginUpdates];
    [viewC.tableView endUpdates];
    
    //NSLog(@"aaa=%f,bbb=%f",size.height,_model.cellHeight);
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView scrollRangeToVisible:textView.selectedRange];
    }
    
    return YES;
}
- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
{
    
    //    NSLog(@"行高  ＝ %f container = %@,xxx = %f",self.textview.font.lineHeight,self.textview.textContainer,self.textview.textContainer.lineFragmentPadding);
    //
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)//
    return adjustedSize;
}
//获取控制器
- (UIViewController *)viewController

{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
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
