//
//  JoinServerViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "JoinServerViewController.h"
#import "SectionHeader_HallFirst.h"
#import "ApplySecondCell.h"
#import "ApplySecondCell_second.h"
#import "AddSinglePhotoCell.h"
#import "ApplyThirdCell.h"
#import "SJAlertView.h"
#import "EditPageViewController.h"
#import "JoinServerModel.h"
#import "SJPickerView.h"
#import "ClipViewController.h"
#import "UIImage+fixOrientation.h"

typedef NS_ENUM(NSInteger,ChosePhotoType) {
    ChosePhotoTypeAlbum,//相册
    ChosePhotoTypeCamera//相机
};

@interface JoinServerViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ClipVCDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property(nonatomic,assign)int imageCellFlag;
@property(nonatomic,strong)SJAlertView *alertView;
//企业简介
@property(nonatomic,strong)NSString *companyIntro;
//企业详情
@property(nonatomic,strong)NSString *companyDetail;
//服务说明
@property(nonatomic,strong)NSString *serverDescription;

@property(nonatomic,strong)JoinServerModel *model;
@property(nonatomic,strong)SJPickerView *catogaryView;
@property(nonatomic,assign)int typeId;//服务类型

@property(nonatomic,strong)UITextField *companyNameTF;
@property(nonatomic,strong)UITextField *addressTF;
//等待审核的状态是不允许修改的
@property(nonatomic,assign)BOOL editable;

@end

@implementation JoinServerViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"加入服务商";
    self.view.backgroundColor=kBackgroundColor;
    self.companyIntro=@"";
    self.companyDetail=@"";
    self.serverDescription=@"";
    self.typeId=-1;
    self.editable=YES;
    [self.view addSubview:self.tableView];
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    //每个用户只能加入一个服务商，提交过之后，下次进就把加入的服务商信息显示
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"user_token":user_token};
    
    [TDHttpTools providerInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            if (![dic[@"data"] isKindOfClass:[NSNull class]]&&dic[@"data"]!=nil) {
                self.model=[[JoinServerModel alloc]initWithDictionary:dic[@"data"]];
                [self.tableView reloadData];
                self.typeId=self.model.typeId;
                self.companyIntro=self.model.descriptions;
                self.companyDetail=self.model.details;
                self.serverDescription=self.model.services;
                self.Id=self.model.Id;
                self.editable=[dic[@"data"][@"editable"] boolValue];
            }
            
        }else if ([dic[@"code"] intValue]==500315){
            //尚未加入服务商
            self.editable=YES;
        }
        
        if (self.editable) {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
        }else{
            self.navigationItem.rightBarButtonItem=nil;
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)rightBarClick{
    //ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (!self.companyNameTF.text.length) {
        [SJTool showAlertWithText:@"企业名称不能为空"];
        return;
    }
    NSString *logo=[self getPhotoString:1];
    if (!logo.length) {
        [SJTool showAlertWithText:@"请上传企业logo"];
        return;
    }
    NSString *licence=[self getPhotoString:2];
    if (!licence.length) {
        [SJTool showAlertWithText:@"请上传营业执照"];
        return;
    }
    if (self.typeId==-1) {
        [SJTool showAlertWithText:@"请选择服务类别"];
        return;
    }
    if (!self.companyIntro.length) {
        [SJTool showAlertWithText:@"请填写企业简介"];
        return;
    }
    if (!self.companyDetail.length) {
        [SJTool showAlertWithText:@"请填写企业详情"];
        return;
    }
    if (!self.serverDescription.length) {
        [SJTool showAlertWithText:@"请填写服务说明"];
        return;
    }
    ApplySecondCell *cell0_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (!cell0_1.textField.text.length) {
        [SJTool showAlertWithText:@"请填写联系人"];
        return;
    }
    ApplySecondCell *cell1_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (!cell1_1.textField.text.length) {
        [SJTool showAlertWithText:@"请填写联系电话"];
        return;
    }
    //ApplySecondCell *cell3_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    if (!self.addressTF.text.length) {
        [SJTool showAlertWithText:@"请填写通讯地址"];
        return;
    }
    ApplySecondCell *cell2_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    NSString *email=@"";
    if (cell2_1.textField.text.length) {
        email=cell2_1.textField.text;
    }
    
    //
    logo=[NSString stringWithFormat:@"data@image/jpg;base64,%@",logo];
    licence=[NSString stringWithFormat:@"data@image/jpg;base64,%@",licence];
    
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSLog(@"%d",(int)self.Id);
    NSDictionary *param=@{@"user_token":user_token,@"id":@(self.Id),@"logo":logo,@"licence":licence,@"title":self.companyNameTF.text,@"description":self.companyIntro,@"details":self.companyDetail,@"services":self.serverDescription,@"typeId":@(self.typeId),@"linker":cell0_1.textField.text,@"linkphone":cell1_1.textField.text,@"address":self.addressTF.text,@"email":email};
    self.alertView=[[SJAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    self.alertView.topLab.text=@"加入服务商申请";
    self.alertView.detailLab.text=@"真实无误的信息可以加快审核进度，点击确认将正式提交申请";
    WS(weakSelf);
    [self.alertView setSureBtnBlock:^{
        NSLog(@"点击确认");
        [weakSelf submitClick:param];
    }];
    
}
-(void)submitClick:(NSDictionary *)param{
    //NSLog(@"----%@",param);
    
    [TDHttpTools joinProviderWithParams:param success:^(id response) {
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
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 7;
    }else{
        return 4;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                NSString *cellID=@"cellIdentifier1";
                ApplySecondCell_second *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell==nil) {
                    cell=[[ApplySecondCell_second alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    self.companyNameTF=cell.textField;
                }
                cell.topLab.text=@"企业名称";
                cell.textField.placeholder=@"请输入企业全称";
                if (self.model) {
                    self.companyNameTF.text=self.model.title;
                }
                cell.showCountLab.hidden=NO;
                self.companyNameTF.delegate=self;
                
                
                return cell;
            }
                break;
            case 1:
            case 2:
            {
                NSString *cellIdentifier=@"cellIdentifier2";
                AddSinglePhotoCell *cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell==nil) {
                    cell=[[AddSinglePhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                     cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row==1) {
                    cell.topLab.text=@"企业logo";
                    if (self.model) {
                        cell.imageUrl=self.model.logo;
                    }
                }else{
                    cell.topLab.text=@"营业执照";
                    if (self.model) {
                        cell.imageUrl=self.model.licence;
                    }
                }
                __weak typeof(self) weakSelf = self;
                
                [cell setAddPhotoBlock:^(){
                    if (indexPath.row==1) {
                        weakSelf.imageCellFlag=1;
                    }else if (indexPath.row==2){
                        weakSelf.imageCellFlag=2;
                    }
                    [weakSelf callActionSheetFunc];
                }];
                return cell;
            }
                break;
            
            case 3:
            {
                static NSString *cellId=@"cellIdentifier3";
                ApplyThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[ApplyThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                   cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.bottomLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
                cell.topLab.text=@"服务类别";
                if (self.model) {
                    cell.bottomLab.text=self.model.type;
                    cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                }else{
                    cell.bottomLab.text=@"请选择";
                }
                
                return cell;
            }
                break;
            case 4:
            case 5:
            case 6:
            {
                static NSString *cellId=@"cellIdentifier4";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                   cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row==4) {
                    cell.textLabel.text=@"企业简介";
                }else if (indexPath.row==5){
                    cell.textLabel.text=@"企业详情";
                }else{
                    cell.textLabel.text=@"服务说明";
                }
                cell.textLabel.font=[UIFont systemFontOfSize:16];
                return cell;
            }
                break;
            default:
                break;
        }
    }else{
        NSString *cellID=@"cellIdentifier5";
        ApplySecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[ApplySecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        switch (indexPath.row) {
            case 0:
                cell.topLab.text=@"联系人";
                cell.textField.placeholder=@"请输入真实姓名";
                if (self.model) {
                    cell.textField.text=self.model.linker;
                }
                break;
            case 1:
                cell.topLab.text=@"联系电话";
                cell.textField.placeholder=@"请输入常用手机号";
                if (self.model) {
                    cell.textField.text=self.model.linkphone;
                }
                cell.textField.keyboardType=UIKeyboardTypeNumberPad;
                break;
            case 2:
                cell.topLab.text=@"联系邮箱";
                cell.textField.placeholder=@"请输入企业邮箱或常用邮箱";
                if (self.model) {
                    cell.textField.text=self.model.email;
                }
                break;
            default:
                cell.topLab.text=@"通讯地址";
                cell.textField.placeholder=@"请输入真实企业地址";
                if (self.model) {
                    cell.textField.text=self.model.address;
                }
                self.addressTF=cell.textField;
                break;
        }
        
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 3:
                [self addCatogaryView];
                break;
            case 4:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"企业简介";
                editVC.oldString=self.companyIntro;
                editVC.isIntro=YES;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.companyIntro=string;
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 5:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"企业详情";
                editVC.oldString=self.companyDetail;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.companyDetail=string;
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 6:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"服务说明";
                editVC.oldString=self.serverDescription;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.serverDescription=string;
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
-(void)addCatogaryView{
    NSDictionary *param=@{@"module":@"provider"};
    
    [TDHttpTools getCatogaryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            
            [self showCatogary:dic[@"data"]];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)showCatogary:(NSMutableArray *)data{
    
    self.catogaryView=[[SJPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240) modelArr:data];
    
    WS(weakSelf);
    __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [self.catogaryView setSureBtnBlock:^(NSDictionary *dic) {
        cell.bottomLab.text=dic[@"name"];
        weakSelf.typeId=[dic[@"id"] intValue];
        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && (indexPath.row==1 || indexPath.row==2)) {
        return 105;
    }else if (indexPath.section==0 && (indexPath.row==4 || indexPath.row==5 || indexPath.row==6)){
        return 44;
    }else{
        return 60;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
        header.contentView.backgroundColor=[UIColor whiteColor];
    }
    NSArray *images=@[@"serviceproviders_information",@"serviceproviders_contact"];
    NSArray *titles=@[@"基本信息",@"联系方式"];
    header.leftIV.image=[UIImage imageNamed:images[section]];
    header.titleLab.text=titles[section];
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=[UIColor whiteColor];
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
    //image=[SJTool imageCompressForWidth:image targetWidth:kScreenWidth];
    
    
    
    if (self.imageCellFlag==1) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self clipImage:[image fixOrientation]];
        }];
        
    }else if (self.imageCellFlag==2){
        AddSinglePhotoCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.imageCellFlag inSection:0]];
        __weak typeof(cell) weakCell = cell;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakCell.currentIma.image=image;
            weakCell.currentIma.contentMode=UIViewContentModeScaleAspectFill;
        });
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - 去裁剪
- (void)clipImage:(UIImage *)img{
    
    ClipViewController * clipVC;
    clipVC = [[ClipViewController alloc]initWithImage:img clipSize:CGSizeMake(320,160)];
    clipVC.clipType = SQUARECLIP;
    clipVC.delegate = self;
    
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:clipVC];
    [self presentViewController:naviVC animated:YES completion:nil];
    
}


#pragma mark - CardClipVCDelegate
-(void)clipViewController:(ClipViewController *)clipViewController finishClipImage:(UIImage *)editImage
{
    
    AddSinglePhotoCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.imageCellFlag inSection:0]];
    
    cell.currentIma.image=editImage;
    
}
-(NSString *)getPhotoString:(int)imageCellFlag{
    AddSinglePhotoCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:imageCellFlag inSection:0]];
    
    UIImageView *imageView=cell.currentIma;
    NSString *imageString=@"";
    
    if (![imageView.image isEqual:[UIImage imageNamed:@"tianjiatupian"]]) {
        //NSLog(@"原照片的大小%ld",UIImageJPEGRepresentation(imageView.image, 1).length);
        NSData *data;
        if (UIImageJPEGRepresentation(imageView.image, 1).length>0 && UIImageJPEGRepresentation(imageView.image, 1).length<=100*1024) {
            data=UIImageJPEGRepresentation(imageView.image, 1);
        }else if (UIImageJPEGRepresentation(imageView.image, 1).length>100*1024 && UIImageJPEGRepresentation(imageView.image, 1).length<=300*1024) {
            data=UIImageJPEGRepresentation(imageView.image, 0.5);
        }else{
            data=UIImageJPEGRepresentation(imageView.image, 0.05);
        }
        
        //NSLog(@"压缩后照片大小:%ld",data.length);
        imageString=[data base64EncodedStringWithOptions:0];
        
    }
    
    return imageString;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (strLength > 15){
        return NO;
    }
    ApplySecondCell_second *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
//键盘变化，移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    //NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    if (deltaY<0) {
        if([self.companyNameTF isFirstResponder]){
            
        }else{
            [UIView animateWithDuration:0.25f animations:^{
                [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY+SafeAreaBottomHeight, self.view.frame.size.width, self.view.frame.size.height)];
            }];
        }
        
    }else{
        if ([self.companyNameTF resignFirstResponder]) {
            
        }else{
            [UIView animateWithDuration:0.25f animations:^{
                [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY-(SafeAreaBottomHeight), self.view.frame.size.width, self.view.frame.size.height)];
            }];
        }
        
    }
    
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
