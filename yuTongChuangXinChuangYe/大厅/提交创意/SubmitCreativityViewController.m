//
//  SubmitCreativityViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SubmitCreativityViewController.h"
#import "ApplySecondCell.h"
#import "AddSinglePhotoCell.h"
#import "ApplyThirdCell.h"
#import "SJPickerView.h"
#import "CreativityEditModel.h"
#import "EditPageViewController.h"
#import "ClipViewController.h"
#import "UIImage+fixOrientation.h"

typedef NS_ENUM(NSInteger,ChosePhotoType) {
    ChosePhotoTypeAlbum,//相册
    ChosePhotoTypeCamera//相机
};

@interface SubmitCreativityViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ClipVCDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property(nonatomic,strong)SJPickerView *catogaryView;
@property(nonatomic,assign)int catogaryID;
@property(nonatomic,strong)CreativityEditModel *model;
@property(nonatomic,strong)NSString *background;//创意背景
@property(nonatomic,strong)NSString *services;//产品介绍
@property(nonatomic,strong)NSString *patterns;//商业模式
@property(nonatomic,strong)NSString *intro;//简介
@property(nonatomic,strong)NSDictionary *saveDic;//存到草稿里面的内容
@end

@implementation SubmitCreativityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"提交你的创意";
    self.background=@"";
    self.services=@"";
    self.patterns=@"";
    self.intro=@"";
    
    UIBarButtonItem *leftBar=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomepage)];
    self.navigationItem.leftBarButtonItem=leftBar;
    
    [self.view addSubview:self.tableView];
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:kChuangYiPath];
    if (dic!=nil) {
        self.saveDic=dic;
        self.catogaryID=[self.saveDic[@"catogaryID"] intValue];
        self.background=self.saveDic[@"background"];
        self.services=self.saveDic[@"services"];
        self.patterns=self.saveDic[@"patterns"];
        self.intro=self.saveDic[@"ideaDescription"];
    }
    
    if (self.isRevise) {
        //修改
        NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
        NSDictionary *param=@{@"ideaId":@(self.ideaId),@"user_token":user_token};
        
        [TDHttpTools creativityInfoWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
                self.model=[[CreativityEditModel alloc]initWithDictionary:dic[@"data"]];
                [self.tableView reloadData];
                self.background=self.model.background;
                self.services=self.model.services;
                self.patterns=self.model.patterns;
                self.catogaryID=self.model.categoryId;
                self.intro=self.model.descriptions;
            }else{
                [SJTool showAlertWithText:dic[@"msg"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(void)backToHomepage{
    ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell0.textField.text.length>0) {
        [self showAlert];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)showAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"退出编辑" message:@"编辑的内容还未保存，确定退出吗" preferredStyle:UIAlertControllerStyleActionSheet];
    WS(weakSelf);
    [alert addAction:[UIAlertAction actionWithTitle:@"保存为草稿" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf saveDraft];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)saveDraft{
    ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ApplySecondCell *cell1_0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ApplySecondCell *cell1_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSString *ideaName=@"";
    if (cell0.textField.text.length) {
        ideaName=cell0.textField.text;
    }
//    NSString *ideaDescription=@"";
//    if (cell1.textField.text.length) {
//        ideaDescription=cell1.textField.text;
//    }
    NSString *name=@"";
    if (cell1_0.textField.text.length) {
        name=cell1_0.textField.text;
    }
    NSString *telephone=@"";
    if (cell1_1.textField.text.length) {
        telephone=cell1_1.textField.text;
    }
    ApplyThirdCell *cell5=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    NSString *hangYeCategory=cell5.bottomLab.text;
    AddSinglePhotoCell *cell6=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    NSData *photo=UIImageJPEGRepresentation(cell6.currentIma.image, 1.0);
    NSDictionary *saveDic=@{@"ideaName":ideaName,@"ideaDescription":self.intro,@"name":name,@"telephone":telephone,@"hangYeCategory":hangYeCategory,@"photo":photo,@"background":self.background,@"services":self.services,@"patterns":self.patterns,@"catogaryID":@(self.catogaryID)};
    
    
    BOOL save=[saveDic writeToFile:kChuangYiPath atomically:YES];
    if (save) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)rightBarClick{
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ApplySecondCell *cell1_0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ApplySecondCell *cell1_1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (!cell0.textField.text.length) {
        [SJTool showAlertWithText:@"请填写名称"];
        return;
    }
//    if (!cell1.textField.text.length) {
//        [SJTool showAlertWithText:@"请填写简介"];
//        return;
//    }
    if (!self.intro.length) {
        [SJTool showAlertWithText:@"请填写简介"];
        return;
    }
    if (!self.services.length) {
        [SJTool showAlertWithText:@"请填写产品介绍"];
        return;
    }
    if (!self.patterns.length) {
        [SJTool showAlertWithText:@"请填写商业模式"];
        return;
    }
    if (self.catogaryID==0) {
        [SJTool showAlertWithText:@"请选择行业分类"];
        return;
    }
    NSString *photo=[self getPhotoString];
    if (!photo.length) {
        [SJTool showAlertWithText:@"请上传宣传图"];
        return;
    }
    if (!cell1_0.textField.text.length) {
        [SJTool showAlertWithText:@"请填写联系人"];
        return;
    }
    if (!cell1_1.textField.text.length) {
        [SJTool showAlertWithText:@"请填写联系电话"];
        return;
    }
    photo=[NSString stringWithFormat:@"data@image/jpg;base64,%@",photo];
    NSDictionary *param=@{@"id":@(self.ideaId),@"user_token":user_token,@"title":cell0.textField.text,@"description":self.intro,@"background":self.background,@"services":self.services,@"patterns":self.patterns,@"categoryId":@(self.catogaryID),@"cover":photo,@"linker":cell1_0.textField.text,@"linkphone":cell1_1.textField.text,@"ispublic":@(1)};
    
    [TDHttpTools submitCreativityWithParams:param success:^(id response) {
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
        _tableView.backgroundColor=[UIColor whiteColor];
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
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            //case 1:
            {
                NSString *cellID=@"cellIdentifier1";
                ApplySecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell==nil) {
                    cell=[[ApplySecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row==0) {
                    cell.topLab.text=@"创意名称";
                    cell.textField.placeholder=@"如新能源电池回收";
                    if (self.saveDic) {
                        cell.textField.text=self.saveDic[@"ideaName"];
                    }
                    if (self.model) {
                        cell.textField.text=self.model.title;
                    }
                }
//                else{
//                    cell.topLab.text=@"创意简介";
//                    cell.textField.placeholder=@"如通过锂电池梯次利用和回收拆解的核心技术，提升电池回收利用率";
//                    if (self.saveDic) {
//                        cell.textField.text=self.saveDic[@"ideaDescription"];
//                    }
//                    if (self.model) {
//                        cell.textField.text=self.model.descriptions;
//                    }
//                }
                cell.showCountLab.hidden=NO;
                cell.textField.delegate=self;
                return cell;
            }
                break;
            
            case 6:
            {
                NSString *cellIdentifier=@"cellIdentifier2";
                AddSinglePhotoCell *cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell==nil) {
                    cell=[[AddSinglePhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                cell.topLab.text=@"上传宣传图";
                if (self.saveDic) {
                    cell.currentIma.image=[UIImage imageWithData:self.saveDic[@"photo"]];
                }
                if (self.model) {
                    cell.imageUrl=self.model.cover;
                }
                __weak typeof(self) weakSelf = self;
                
                [cell setAddPhotoBlock:^(){
                    
                    [weakSelf callActionSheetFunc];
                }];
                return cell;
            }
                break;
                
            case 5:
            {
                static NSString *cellId=@"cellIdentifier3";
                ApplyThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[ApplyThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.bottomLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
                cell.topLab.text=@"行业分类";
                if (self.saveDic) {
                    cell.bottomLab.text=self.saveDic[@"hangYeCategory"];
                    if (![cell.bottomLab.text isEqualToString:@"请选择行业"]) {
                        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                    }
                }else{
                    cell.bottomLab.text=@"请选择行业";
                }
                if (self.model) {
                    cell.bottomLab.text=self.model.category;
                    cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                }
                return cell;
            }
                break;
            case 1:
            case 2:
            case 3:
            case 4:
            {
                static NSString *cellId=@"cellIdentifier4";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row==1) {
                    cell.textLabel.text=@"创意简介";
                    if (self.intro.length) {
                        cell.detailTextLabel.text=@"已完成";
                    }else{
                        cell.detailTextLabel.text=@"待填写";
                    }
                }else if (indexPath.row==2) {
                    cell.textLabel.text=@"创意背景";
                    if (self.background.length) {
                        cell.detailTextLabel.text=@"已完成";
                    }else{
                        cell.detailTextLabel.text=@"待填写";
                    }
                }else if (indexPath.row==3){
                    cell.textLabel.text=@"产品介绍";
                    if (self.services.length) {
                        cell.detailTextLabel.text=@"已完成";
                    }else{
                        cell.detailTextLabel.text=@"待填写";
                    }
                }else{
                    cell.textLabel.text=@"商业模式";
                    if (self.patterns.length) {
                        cell.detailTextLabel.text=@"已完成";
                    }else{
                        cell.detailTextLabel.text=@"待填写";
                    }
                }
                cell.textLabel.font=[UIFont systemFontOfSize:16];
                cell.detailTextLabel.font=[UIFont systemFontOfSize:16];
                return cell;
            }
                break;
            default:
                break;
        }
    }else{
        NSString *cellID=@"cellIdentifie5";
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
                if (self.saveDic) {
                    cell.textField.text=self.saveDic[@"name"];
                }
                if (self.model) {
                    cell.textField.text=self.model.linker;
                }
                break;
            case 1:
                cell.topLab.text=@"联系电话";
                cell.textField.placeholder=@"请输入常用手机号";
                if (self.saveDic) {
                    cell.textField.text=self.saveDic[@"telephone"];
                }
                if (self.model) {
                    cell.textField.text=self.model.linkphone;
                }
                cell.textField.keyboardType=UIKeyboardTypeNumberPad;
                break;
            default:
                break;
        }
        
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && indexPath.row==6) {
        return 105;
    }else if (indexPath.section==0 && (indexPath.row==1 || indexPath.row==2 || indexPath.row==3 || indexPath.row==4)){
        return 44;
    }else{
        return 60;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head=[[UIView alloc]init];
    if (section==1) {
        UITableViewHeaderFooterView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (!header) {
            header=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
            header.contentView.backgroundColor=kBackgroundColor;//[UIColor whiteColor];
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth-30, 20)];
            lab.backgroundColor=kBackgroundColor;
            lab.font=[UIFont systemFontOfSize:12];
            lab.textColor=[UIColor colorWithHexString:@"#989898"];
            lab.text=@"以下内容将严格保密，不做展示";
            [header addSubview:lab];
        }
        head=header;
    }
    
    return head;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;//[UIColor whiteColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 1:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"创意简介";
                editVC.oldString=self.intro;
                editVC.isIntro=YES;
                editVC.countControl=YES;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.intro=string;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 2:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"创意背景";
                editVC.oldString=self.background;
                editVC.isIntro=YES;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.background=string;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 3:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"产品介绍";
                editVC.oldString=self.services;
                editVC.isIntro=YES;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.services=string;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 4:
            {
                EditPageViewController *editVC=[EditPageViewController new];
                editVC.title=@"商业模式";
                editVC.oldString=self.patterns;
                editVC.isIntro=YES;
                WS(weakSelf);
                [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                    weakSelf.patterns=string;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
                [self.navigationController pushViewController:editVC animated:YES];
            }
                break;
            case 5:
            {
                [self addCatogaryView];
            }
                break;
            default:
                break;
        }
        
    }
}

 -(void)addCatogaryView{
     NSDictionary *param=@{@"module":@"project"};
     
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
     __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
     [self.catogaryView setSureBtnBlock:^(NSDictionary *dic) {
         cell.bottomLab.text=dic[@"name"];
         weakSelf.catogaryID=[dic[@"id"] intValue];
         cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
     }];
 
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
    imagePickerController.allowsEditing = NO;
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
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self clipImage:[image fixOrientation]];
    }];
    
}
#pragma mark - 去裁剪
- (void)clipImage:(UIImage *)img{
    
    ClipViewController * clipVC;
    clipVC = [[ClipViewController alloc]initWithImage:img clipSize:CGSizeMake(330,210)];
    clipVC.clipType = SQUARECLIP;
    clipVC.delegate = self;
    
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:clipVC];
    [self presentViewController:naviVC animated:YES completion:nil];
    
}


#pragma mark - CardClipVCDelegate
-(void)clipViewController:(ClipViewController *)clipViewController finishClipImage:(UIImage *)editImage
{
    AddSinglePhotoCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.currentIma.image=editImage;
    
}
-(NSString *)getPhotoString{
    AddSinglePhotoCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    
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
    
    ApplySecondCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if ([textField isEqual:cell.textField]) {
        if (strLength > 15){
            return NO;
        }
        NSString *str=[NSString stringWithFormat:@"%d/15",(int)strLength];
        NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(str.length-2, 2)];
        cell.showCountLab.attributedText=attriStr;
    }
//    else if([textField isEqual:cell1.textField]){
//        if (strLength > 50){
//            return NO;
//        }
//        NSString *str=[NSString stringWithFormat:@"%d/50",(int)strLength];
//        NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
//        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(str.length-2, 2)];
//        cell1.showCountLab.attributedText=attriStr;
//    }
    
    
    return YES;
}
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    ApplySecondCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (cell.textField.isFirstResponder || cell1.textField.isFirstResponder) {
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        //上移n个单位，按实际情况设置
        CGRect rect=CGRectMake(0.0f,-100.0f,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
    }
    
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    ApplySecondCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if ([cell.textField resignFirstResponder] || [cell1.textField resignFirstResponder]) {
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        
        CGRect rect=CGRectMake(0.0f,kNavigationBarHeight+kStatusBarHeight,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
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
