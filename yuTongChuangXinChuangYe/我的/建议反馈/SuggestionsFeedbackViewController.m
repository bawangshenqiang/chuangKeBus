//
//  SuggestionsFeedbackViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SuggestionsFeedbackViewController.h"

#import "LMJDropdownMenu.h"
#import "ImageShowCollectionViewCell.h"
#import "ImageShowFlowLayout.h"
#import <PhotoSolution/PhotoSolution-Swift.h>

@interface SuggestionsFeedbackViewController ()<LMJDropdownMenuDelegate,UICollectionViewDelegate, UICollectionViewDataSource,PhotoSolutionDelegate>

@property(nonatomic,strong)LMJDropdownMenu *choseStyle;
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *currentImages;
@property(nonatomic,assign)int maxPhotos;

@property(nonatomic,strong)NSString *type;

@end

@implementation SuggestionsFeedbackViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"建议反馈";
    self.view.backgroundColor=kBackgroundColor;
    self.currentImages=[NSMutableArray array];
    self.maxPhotos=9;
    self.type=@"";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitClick)];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissKeyboard:) name:@"DismissKeyBoard" object:nil];
    //
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight)];
    scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    //
    UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    leftLab.textColor=[UIColor colorWithHexString:@"#323232"];
    leftLab.text=@"反馈类型";
    leftLab.font=[UIFont systemFontOfSize:15];
    [scrollView addSubview:leftLab];
    //
    self.choseStyle=[[LMJDropdownMenu alloc]init];
    self.choseStyle.frame=CGRectMake(scrollView.width-110, 0, 100, 40);
    [self.choseStyle setMenuTitles:@[@"使用问题",@"产品建议",@"BUG提交"] rowHeight:40];
    self.choseStyle.delegate = self;
    [scrollView addSubview:self.choseStyle];
    //
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(10, leftLab.bottom, kScreenWidth-25, 0.4)];
    line1.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    [scrollView addSubview:line1];
    //
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10, line1.bottom+10, scrollView.width-20, 200)];
    self.textView.font=[UIFont systemFontOfSize:14];
    self.textView.textColor=[UIColor colorWithHexString:@"#989898"];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请详细描述您对产品的建议或遇到的问题";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self.textView addSubview:placeHolderLabel];
    placeHolderLabel.font = [UIFont systemFontOfSize:14];
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [self.textView setInputAccessoryView:[SJTool backToolBarView]];
    [scrollView addSubview:self.textView];
    //
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(10, self.textView.bottom+10, kScreenWidth-20, 0.4)];
    line2.backgroundColor=RGBAColor(145, 165, 165, 0.5);
    [scrollView addSubview:line2];
    //
    UILabel *uploadLab=[[UILabel alloc]initWithFrame:CGRectMake(10, line2.bottom+15, kScreenWidth-20, 20)];
    uploadLab.text=@"上传图片（选填）";
    uploadLab.font=[UIFont systemFontOfSize:15];
    uploadLab.textColor=[UIColor colorWithHexString:@"#989898"];
    [scrollView addSubview:uploadLab];
    //
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, uploadLab.bottom+10, kScreenWidth, kScreenWidth) collectionViewLayout:[[ImageShowFlowLayout alloc]init]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageShowCollectionViewCell"];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:self.collectionView];
    
    //
    [scrollView setupAutoContentSizeWithBottomView:self.collectionView bottomMargin:20];
    
}
#pragma mark - collectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.currentImages.count<self.maxPhotos) {
        return self.currentImages.count+1;
    }else{
        return self.maxPhotos;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageShowCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageShowCollectionViewCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    if (indexPath.row == _currentImages.count){
        cell.imageView.image = [UIImage imageNamed:@"tianjiatupian"];
        cell.delete.hidden=YES;
    }else{
        cell.imageView.image = _currentImages[indexPath.row];
        cell.delete.hidden=NO;
    }
    WS(weakSelf);
    [cell setDeleteImageBlock:^(ImageShowCollectionViewCell * _Nonnull cell) {
        [weakSelf.currentImages removeObjectAtIndex:cell.tag];
        [weakSelf.collectionView reloadData];
    }];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==_currentImages.count) {
        PhotoSolution *photoSolution=[[PhotoSolution alloc]init];
        photoSolution.delegate=self;
        
        photoSolution.customization.markerColor = [UIColor colorWithRed:0.14 green:0.72 blue:0.30 alpha:1.0];
        photoSolution.customization.navigationBarBackgroundColor = UIColor.darkGrayColor;
        photoSolution.customization.navigationBarTextColor = UIColor.whiteColor;
        photoSolution.customization.titleForAlbum = @"Album";
        photoSolution.customization.alertTextForPhotoAccess = @"Your App Would Like to Access Your Photos";
        photoSolution.customization.settingButtonTextForPhotoAccess = @"Setting";
        photoSolution.customization.cancelButtonTextForPhotoAccess = @"Cancel";
        photoSolution.customization.alertTextForCameraAccess = @"Your App Would Like to Access Your Photos";
        photoSolution.customization.settingButtonTextForCameraAccess = @"Setting";
        photoSolution.customization.cancelButtonTextForCameraAccess = @"Cancel";
        photoSolution.customization.returnImageSize = ReturnImageSizeCompressed;
        photoSolution.customization.statusBarColor = StatusBarColorWhite;
        WS(weakSelf);
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf presentViewController: [photoSolution getCamera] animated:YES completion:nil];
        }];
        UIAlertAction *albumAction=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            int remainPhotos = weakSelf.maxPhotos - weakSelf.currentImages.count;
            [weakSelf presentViewController: [photoSolution getPhotoPickerWithMaxPhotos:remainPhotos] animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:photoAction];
        [alert addAction:albumAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
//implement delegate method
-(void)returnImages:(NSArray *)images{
    for (UIImage *image in images) {
        if (_currentImages.count<_maxPhotos) {
            [_currentImages addObject:image];
        }
    }
    [self.collectionView reloadData];
}

-(void)pickerCancel{
    // when user cancel picking photo
}
#pragma mark - LMJDropdownMenu Delegate

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    NSLog(@"你选择了：%ld",number);
    switch (number) {
        case 0:
            self.type=@"question";
            break;
        case 1:
            self.type=@"advice";
            break;
        case 2:
            self.type=@"bug";
            break;
        default:
            break;
    }
}

-(void)submitClick{
    NSLog(@"提交");
    if (!self.type.length) {
        [SJTool showAlertWithText:@"请选择反馈类型"];
        return;
    }
    if (!self.textView.text.length) {
        [SJTool showAlertWithText:@"请填写建议或问题"];
        return;
    }
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSMutableArray *picture=[NSMutableArray array];
    if (self.currentImages.count>0) {
        for (int i=0; i<self.currentImages.count; i++) {
            UIImage *image=self.currentImages[i];
            NSString *imageStr=[self getPhotoStringWith:image];
            imageStr=[NSString stringWithFormat:@"data@image/jpg;base64,%@",imageStr];
            NSDictionary *dic=@{@"uri":imageStr};
            [picture addObject:dic];
        }
    }
    NSData *data=[NSJSONSerialization dataWithJSONObject:picture options:NSJSONWritingPrettyPrinted error:nil];
    NSString *pictureJson=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *phone=[Account sharedAccount].telephone;
    if (phone==nil) {
        phone=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"feedback":self.textView.text,@"type":self.type,@"linkphone":phone,@"picture":pictureJson};
    [TDHttpTools userSegmentWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
-(NSString *)getPhotoStringWith:(UIImage *)image{
    
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
