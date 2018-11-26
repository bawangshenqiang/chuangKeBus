//
//  PublishThemeViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "PublishThemeViewController.h"
#import "PullDownCell_Publish.h"
#import "SingleTextFieldCell.h"
#import "BottomView_Publish.h"
#import "TextViewCell_Publish.h"

typedef NS_ENUM(NSInteger,ChosePhotoType) {
    ChosePhotoTypeAlbum,//相册
    ChosePhotoTypeCamera//相机
};

@interface PublishThemeViewController ()<UITableViewDelegate,UITableViewDataSource,LMJDropdownMenuDelegate,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BottomView_Publish *bottomView;
@property(nonatomic,strong)UITextView *textView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property (nonatomic,assign)CGFloat imageWidth;
//光标位置
@property (nonatomic,assign)NSRange curserRange;

@property(nonatomic,assign)int categoryId;//版块
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)NSString *content;

@end

@implementation PublishThemeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发表主题";
    self.view.backgroundColor=kBackgroundColor;
    _imageWidth = 100;
    _categoryId=-1;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    [self.view addSubview:self.tableView];
    //
    self.bottomView=[[BottomView_Publish alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, kScreenWidth, 50)];
    WS(weakSelf);
    [self.bottomView setFontBtnBlock:^{
        NSLog(@"粗体");
        [weakSelf setBlodFont];
    }];
    [self.bottomView setImageBtnBlock:^{
        NSLog(@"插图");
        [weakSelf callActionSheetFunc];
    }];
    [self.view addSubview:self.bottomView];
    if (self.isRevise) {
        //修改
        NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
        NSDictionary *param=@{@"user_token":user_token,@"postId":@(self.postId)};
        
        [TDHttpTools postInfoWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
                self.themeArr=dic[@"data"][@"themes"];
                self.category=dic[@"data"][@"post"][@"category"];
                self.categoryId=[dic[@"data"][@"post"][@"categoryId"] intValue];
                self.titleName=dic[@"data"][@"post"][@"title"];
                self.content=dic[@"data"][@"post"][@"content"];
                [self.tableView reloadData];
                
            }else{
                [SJTool showAlertWithText:dic[@"msg"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(void)setBlodFont{
    TextViewCell_Publish *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSAttributedString *att=cell.textView.attributedText;
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithAttributedString:att];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:_curserRange];
    cell.textView.attributedText=str;
    
}
//发表
-(void)rightBarClick{
    
    if (_categoryId==-1) {
        [SJTool showAlertWithText:@"请选择版块"];
        return;
    }
    SingleTextFieldCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (!cell1.textField.text.length) {
        [SJTool showAlertWithText:@"请输入标题"];
        return;
    }
    NSString *content=[self getPublishString];
    if (!content.length) {
        [SJTool showAlertWithText:@"请输入正文"];
        return;
    }
    
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"id":@(self.postId),@"user_token":user_token,@"title":cell1.textField.text,@"categoryId":@(self.categoryId),@"content":content};
    
    [TDHttpTools submitPostWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(NSString *)getPublishString{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    //TextViewCell_Publish *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
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
    //NSLog(@"%@",resultString);
    return resultString;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight-50) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.scrollEnabled=NO;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        NSString *cellID=@"cellIdentifier";
        PullDownCell_Publish *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[PullDownCell_Publish alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        NSMutableArray *titles=[NSMutableArray array];
        for (NSDictionary *dic in self.themeArr) {
            [titles addObject:dic[@"name"]];
        }
        cell.titleArr=titles;
        cell.choseStyle.delegate=self;
        if (self.categoryId!=-1) {
            [cell.choseStyle.mainBtn setTitle:self.category forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.row==1){
        NSString *cellID=@"cellIdentifier2";
        SingleTextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[SingleTextFieldCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textField.delegate=self;
        cell.showCountLab.hidden=NO;
        NSString *str=@"请输入标题";
        NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str.length)];
        cell.textField.attributedPlaceholder=attriStr;
        if (self.titleName.length) {
            cell.textField.text=self.titleName;
        }
        return cell;
    }else{
        NSString *cellID=@"cellIdentifier3";
        TextViewCell_Publish *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[TextViewCell_Publish alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textView.delegate=self;
        cell.placeHolderLabel.text=@"请输入正文";
        self.textView=cell.textView;
        if (self.content.length) {
            [self setOldStringToAttributeString:self.content];
        }
        return cell;
    }
    return nil;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return kTableViewHeight-50-88;
    }
    return 44;
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
    
    TextViewCell_Publish *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image=[SJTool imageCompressForWidth:image targetWidth:kScreenWidth];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:cell.textView.attributedText];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, _imageWidth, _imageWidth);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri replaceCharactersInRange:_curserRange withAttributedString:string];
    
    cell.textView.attributedText = attri;
    [cell.textView setFont:[UIFont systemFontOfSize:16]];
    
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
//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}
#pragma mark - UITextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (strLength > 15){
        return NO;
    }
    SingleTextFieldCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *str=[NSString stringWithFormat:@"%d/15",(int)strLength];
    NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(str.length-2, 2)];
    cell.showCountLab.attributedText=attriStr;
    //    NSString *text = nil;
    //    //如果string为空，表示删除
    //    if (string.length > 0) {
    //        text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //    }else{
    //        text = [textField.text substringToIndex:range.location];
    //    }
    return YES;
}
#pragma mark - UITextView Delegate
- (void)textViewDidChangeSelection:(UITextView *)textView {
    //NSLog(@"光标位置%ld——%ld",textView.selectedRange.location,textView.selectedRange.length);
    _curserRange = textView.selectedRange;
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSDictionary *dic=self.themeArr[number];
    //NSLog(@"你选择了：%@,%@",dic[@"id"],dic[@"name"]);
    self.categoryId=[dic[@"id"] intValue];
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
