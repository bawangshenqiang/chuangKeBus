//
//  EditPageViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "EditPageViewController.h"
#import "BottomView_Publish.h"

typedef NS_ENUM(NSInteger,ChosePhotoType) {
    ChosePhotoTypeAlbum,//相册
    ChosePhotoTypeCamera//相机
};

@interface EditPageViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)BottomView_Publish *bottomView;
@property(nonatomic,strong)UITextView *textView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property (nonatomic,assign)CGFloat imageWidth;
//光标位置
@property (nonatomic,assign)NSRange curserRange;

@property(nonatomic,strong)UILabel *countLab;//提示字数的label

@end

@implementation EditPageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _imageWidth = 100;
    
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomepage)];
    self.navigationItem.leftBarButtonItem=leftBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    //
    [self.view addSubview:self.textView];
    //
    self.bottomView=[[BottomView_Publish alloc]initWithFrame:CGRectMake(0, self.textView.bottom, kScreenWidth, 50)];
    WS(weakSelf);
    [self.bottomView setFontBtnBlock:^{
        NSLog(@"粗体");
        [weakSelf setBlodFont];
    }];
    [self.bottomView setImageBtnBlock:^{
        NSLog(@"插图");
        [weakSelf callActionSheetFunc];
    }];
    //企业简介不能插入图片，只有文字
    if (!self.isIntro) {
        [self.view addSubview:self.bottomView];
    }
    //
    if (_oldString != nil && ![_oldString isEqualToString:@""]) {
        [self setOldStringToAttributeString:_oldString];
    }
}
-(void)backToHomepage{
    
    if (self.textView.text.length>0) {
        [self showAlert];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)showAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"退出编辑" message:@"编辑的内容还未保存，确定退出吗" preferredStyle:UIAlertControllerStyleActionSheet];
    WS(weakSelf);
    [alert addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setOldStringToAttributeString:(NSString *)oldHtmlString {
    NSString *oldString1 = oldHtmlString;
    //@"< img src=\"data@image/jpg;base64,"
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"<img src=\"" withString:@"<div>"];
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"\"/>" withString:@"<div>"];
    oldString1 = [oldString1 stringByReplacingOccurrencesOfString:@"<div><div>" withString:@"<div>"];
    NSArray *resultArray = [oldString1 componentsSeparatedByString:@"<div>"];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < resultArray.count; i ++) {
        
        if (![resultArray[i] isEqualToString:@""]) {
            NSData *data=nil;
            NSString *tempString = resultArray[i];
            if ([tempString containsString:@"data@image/jpg;base64,"]) {
                
                tempString = [tempString stringByReplacingOccurrencesOfString:@"data@image/jpg;base64," withString:@""];
                
                data=[[NSData alloc]initWithBase64EncodedString:tempString options:NSDataBase64DecodingIgnoreUnknownCharacters];
                
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                // 表情图片
                attch.image = [UIImage imageWithData:data];
                // 设置图片大小
                attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
                // 创建带有图片的富文本
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
                [resultAttributedString appendAttributedString:string];
            }else if ([tempString containsString:@"http"]){
                data=[NSData dataWithContentsOfURL:[NSURL URLWithString:tempString]];
                NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                // 表情图片
                attch.image = [UIImage imageWithData:data];
                // 设置图片大小
                attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
                // 创建带有图片的富文本
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
                [resultAttributedString appendAttributedString:string];
            }else {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:resultArray[i]];
                
                [resultAttributedString appendAttributedString:string];
            }
        }
    }
    self.textView.attributedText = resultAttributedString;
    [self.textView setFont:[UIFont systemFontOfSize:16]];
}
-(UITextView *)textView{
    if (!_textView) {
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, kTableViewHeight-50)];
        _textView.delegate=self;
        _textView.backgroundColor=[UIColor whiteColor];
        _textView.font=[UIFont systemFontOfSize:16];
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text=@"请输入内容...";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [_textView addSubview:placeHolderLabel];
        placeHolderLabel.font = [UIFont systemFontOfSize:16];
        //kvc改变私有属性
        [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        [_textView setInputAccessoryView:[SJTool backToolBarView]];
        //
        if (self.countControl) {
            self.countLab=[[UILabel alloc]initWithFrame:CGRectMake(_textView.width-85, 70, 80, 20)];
            self.countLab.font=[UIFont systemFontOfSize:12];
            self.countLab.textAlignment=NSTextAlignmentRight;
            self.countLab.textColor=[UIColor colorWithHexString:@"#989898"];
            self.countLab.text=@"50字以内";
            [_textView addSubview:self.countLab];
        }
    }
    return _textView;
}
-(void)setBlodFont{
    
    NSAttributedString *att=self.textView.attributedText;
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithAttributedString:att];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:_curserRange];
    self.textView.attributedText=str;
    
}
//保存
-(void)rightBarClick{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSAttributedString * att = self.textView.attributedText;
    NSMutableAttributedString * resultAtt = [[NSMutableAttributedString alloc]initWithAttributedString:att];
    [att enumerateAttributesInRange:NSMakeRange(0, att.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSTextAttachment * textAtt = attrs[@"NSAttachment"];
        if (textAtt) {
            UIImage * image = textAtt.image;
            NSString *imageBase64=[self getPhotoStringFromImage:image];
            [resultString insertString:[NSString stringWithFormat:@"<img src=\"data@image/jpg;base64,%@\"/>",imageBase64] atIndex:0];
        }else{
            [resultString insertString:[resultAtt attributedSubstringFromRange:range].string atIndex:0];
        }
    }];
    NSLog(@"%@",resultString);
    if (self.callBackBlock) {
        self.callBackBlock(resultString);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)callActionSheetFunc{
    WS(weakSelf);
    self.actionSheet=[UIAlertController alertControllerWithTitle:@"选择图像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.actionSheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf chosePhoto:ChosePhotoTypeCamera];
    }]];
    [self.actionSheet addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf chosePhoto:ChosePhotoTypeAlbum];
    }]];
    [self.actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:self.actionSheet animated:YES completion:nil];
}
-(void)chosePhoto:(ChosePhotoType)type{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //imagePickerController.allowsEditing = YES;
    if (type==ChosePhotoTypeAlbum) {
        imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (type==ChosePhotoTypeCamera){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
            return;
        }
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image=[SJTool imageCompressForWidth:image targetWidth:kScreenWidth];
    
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri replaceCharactersInRange:_curserRange withAttributedString:string];
    
    self.textView.attributedText = attri;
    [self.textView setFont:[UIFont systemFontOfSize:16]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(NSString *)getPhotoStringFromImage:(UIImage *)image{
    
    
    NSString *imageString=@"";
    
    if (image!=nil) {
        
        NSData *data;
        if (UIImageJPEGRepresentation(image, 1).length>0 && UIImageJPEGRepresentation(image, 1).length<=100*1024) {
            data=UIImageJPEGRepresentation(image, 1);
        }else if (UIImageJPEGRepresentation(image, 1).length>100*1024 && UIImageJPEGRepresentation(image, 1).length<=300*1024) {
            data=UIImageJPEGRepresentation(image, 0.5);
        }else{
            data=UIImageJPEGRepresentation(image, 0.05);
        }
        
        //NSLog(@"压缩后照片大小:%ld",data.length);
        imageString=[data base64EncodedStringWithOptions:0];
        
    }
    
    return imageString;
}
#pragma mark - UITextView Delegate
- (void)textViewDidChangeSelection:(UITextView *)textView {
    //NSLog(@"光标位置%ld——%ld",textView.selectedRange.location,textView.selectedRange.length);
    _curserRange = textView.selectedRange;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSInteger strLength = textView.text.length - range.length + text.length;
    if (self.countControl && strLength > 50){
        return NO;
    }
    if (self.countControl) {
        NSString *str=[NSString stringWithFormat:@"%d/50",(int)strLength];
        NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(str.length-2, 2)];
        self.countLab.attributedText=attriStr;
    }
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
