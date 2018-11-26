//
//  UserInfomationViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "UserInfomationViewController.h"
#import "Header_UserInfo.h"
#import "ApplySecondCell.h"
#import "ApplyThirdCell.h"
#import "CustomDatePickerView.h"
#import "CustomCityPickerView.h"
#import "CustomPickerView.h"

typedef NS_ENUM(NSInteger,ChosePhotoType) {
    ChosePhotoTypeAlbum,//相册
    ChosePhotoTypeCamera//相机
};

@interface UserInfomationViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (strong, nonatomic) UIAlertController *actionSheet;
@property(nonatomic,strong)Header_UserInfo *headerView;
@property(nonatomic,strong)NSArray *pickerArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)CustomPickerView *graderPickerView;
@property(nonatomic,assign)int grader;

@end

@implementation UserInfomationViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)getData{
    //获取文件路径
    NSString*path=[[NSBundle mainBundle]pathForResource:@"province"ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    self.pickerArr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dic in self.pickerArr) {
        
        NSMutableArray *citys=[NSMutableArray array];
        for (NSDictionary *dict in dic[@"city"]) {
            [citys addObject:dict[@"name"]];
        }
        [self.dataArr addObject:@{@"province":dic[@"name"],@"city":citys}];
    }
    //NSLog(@"dataArr==%@",self.dataArr);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人资料";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    self.grader=[Account sharedAccount].gender;
    
    [self.view addSubview:self.tableView];
    
    [self getData];
}
-(void)rightBarClick{
    ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ApplySecondCell *cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    ApplyThirdCell *cell3=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    ApplyThirdCell *cell4=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    ApplyThirdCell *cell5=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    if (!cell0.textField.text.length) {
        [SJTool showAlertWithText:@"请填写昵称"];
        return;
    }
    if (!cell1.textField.text.length) {
        [SJTool showAlertWithText:@"请填写姓名"];
        return;
    }
    if (!cell2.textField.text.length) {
        [SJTool showAlertWithText:@"请填写个人简介"];
        return;
    }
    if (!cell3.bottomLab.text.length) {
        [SJTool showAlertWithText:@"请选择居住地"];
        return;
    }
    if (!cell4.bottomLab.text.length) {
        [SJTool showAlertWithText:@"请选择出生日期"];
        return;
    }
    if (!cell5.bottomLab.text.length) {
        [SJTool showAlertWithText:@"请选择性别"];
        return;
    }
    NSString *nickname=cell0.textField.text;
    NSString *name=cell1.textField.text;
    NSString *descriptions=cell2.textField.text;
    NSString *birthday=cell4.bottomLab.text;
    NSString *photo=[self getPhotoString];
    //
    photo=[NSString stringWithFormat:@"data@image/jpg;base64,%@",photo];
    NSString *area=cell3.bottomLab.text;
    NSString *province=[area componentsSeparatedByString:@"-"].firstObject;
    NSString *city=[area componentsSeparatedByString:@"-"].lastObject;
    
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"user_token":token,@"photo":photo,@"nickname":nickname,@"name":name,@"description":descriptions,@"birthday":birthday,@"province":province,@"city":city,@"homepage":@(0),@"gender":@(self.grader)};
    [TDHttpTools updateUserInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            
            [self getUserInfro];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getUserInfro{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools getUserInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            NSDictionary *userDict = [dic[@"data"] copy];
            [Account sharedAccount].nickname=userDict[@"nickname"];
            [Account sharedAccount].name=userDict[@"name"];
            [Account sharedAccount].descriptions=userDict[@"description"];
            [Account sharedAccount].birthday=userDict[@"birthday"];
            [Account sharedAccount].city=userDict[@"city"];
            [Account sharedAccount].photo=userDict[@"photo"];
            [Account sharedAccount].province=userDict[@"province"];
            [Account sharedAccount].gender=[userDict[@"gender"] intValue];
            [Account sharedAccount].provinceId=[userDict[@"provinceId"] intValue];
            [Account sharedAccount].cityId=[userDict[@"cityId"] intValue];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"已保存"];
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
        _tableView.tableHeaderView=[self header];
    }
    return _tableView;
}
-(UIView *)header{
    Header_UserInfo *header=[[Header_UserInfo alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    [header.headIV sd_setImageWithURL:[NSURL URLWithString:[Account sharedAccount].photo] placeholderImage:[UIImage imageNamed:@"hall_user"]];
    self.headerView=header;
    WS(weakSelf);
    [header setSetImageBlock:^{
        NSLog(@"设置头像");
        [weakSelf callActionSheetFunc];
    }];
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        {
            NSString *cellID=@"cellIdentifier1";
            ApplySecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell==nil) {
                cell=[[ApplySecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (indexPath.row==0) {
                cell.topLab.text=@"昵称";
                cell.textField.placeholder=@"ME";
                if ([Account sharedAccount]) {
                    cell.textField.text=[Account sharedAccount].nickname;
                }
            }else if (indexPath.row==1){
                cell.topLab.text=@"姓名";
                cell.textField.placeholder=@"ME";
                if ([Account sharedAccount]) {
                    cell.textField.text=[Account sharedAccount].name;
                }
            }else{
                cell.topLab.text=@"个人简介";
                cell.textField.placeholder=@"一句话介绍自己";
                if ([Account sharedAccount]) {
                    cell.textField.text=[Account sharedAccount].descriptions;
                }
            }
            return cell;
        }
            break;
        case 3:
        case 4:
        case 5:
        {
            static NSString *cellId=@"cellIdentifier2";
            ApplyThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[ApplyThirdCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            
            
            cell.bottomLab.textColor=[UIColor colorWithHexString:@"#cccccc"];
            if (indexPath.row==3) {
                cell.topLab.text=@"居住地";
                cell.bottomLab.text=@"请选择";
                if ([Account sharedAccount] && ![[Account sharedAccount].province isEqualToString:@""]) {
                    cell.bottomLab.text=[NSString stringWithFormat:@"%@-%@",[Account sharedAccount].province,[Account sharedAccount].city];
                    cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                }
            }else if(indexPath.row==4){
                cell.topLab.text=@"生日";
                cell.bottomLab.text=@"请选择日期";
                if ([Account sharedAccount] && ![[Account sharedAccount].birthday isEqualToString:@""]) {
                    cell.bottomLab.text=[Account sharedAccount].birthday;
                    cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                }
            }else{
                cell.topLab.text=@"性别";
                cell.bottomLab.text=@"请选择";
                if ([Account sharedAccount]) {
                    switch ([Account sharedAccount].gender) {
                        case 0:
                            cell.bottomLab.text=@"男士";
                            break;
                        case 1:
                            cell.bottomLab.text=@"女士";
                        default:
                            cell.bottomLab.text=@"保密";
                            break;
                    }
                    cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                }
            }
            return cell;
        }
        default:
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        CustomCityPickerView *cityPicker=[[CustomCityPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) data:self.dataArr CompleteBlock:^(NSString * string) {
            
        }];
        [cityPicker setSureClickBlock:^(NSString * string) {
            cell.bottomLab.text=string;
            cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
        }];
        [cityPicker show];
        
    }else if (indexPath.row==4){
        [self addDatePickerView];
    }else if (indexPath.row==5){
        [self addPickView2];
    }
}
-(void)addPickView2{
    
    self.graderPickerView=[[CustomPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240) titleArr:@[@"男士",@"女士",@"保密"]];
    
    WS(weakSelf);
    __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    [self.graderPickerView setSureBtnBlock:^(NSString *title,NSInteger index) {
        cell.bottomLab.text=title;
        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
        weakSelf.grader=index;
        if (index==2) {
            weakSelf.grader=-1;
        }
    }];
}
-(void)addDatePickerView{
    
    
    //WS(weakSelf);
    __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *format = @"yyyy-MM-dd";
    
    CustomDatePickerView *customView=[[CustomDatePickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) CompleteBlock:^(NSDate *theDate) {
        if (theDate) {
            //weakSelf.payMoneyTime = [theDate stringWithFormat:format];
            
            cell.bottomLab.text=[theDate stringWithFormat:format];
            cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
        }
    }];
    customView.datePicker.datePickerMode = UIDatePickerModeDate;
    [customView show];
    
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
    //image=[SJTool imageCompressForWidth:image targetWidth:100];
    
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.headerView.headIV.image=image; weakSelf.headerView.headIV.contentMode=UIViewContentModeScaleAspectFill;
    });
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(NSString *)getPhotoString{
    
    UIImageView *imageView=self.headerView.headIV;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
