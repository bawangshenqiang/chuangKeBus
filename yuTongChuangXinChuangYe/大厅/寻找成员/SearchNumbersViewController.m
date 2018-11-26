//
//  SearchNumbersViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchNumbersViewController.h"
#import "ApplySecondCell.h"
#import "ApplyThirdCell.h"
#import "SJPickerView.h"
#import "TeamEditModel.h"
#import "CustomCityPickerView.h"
#import "EditPageViewController.h"


@interface SearchNumbersViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)SJPickerView *catogaryView;
@property(nonatomic,assign)int catogaryID;
@property(nonatomic,strong)TeamEditModel *model;
@property(nonatomic,strong)NSString *project;
@property(nonatomic,strong)NSString *team;
@property(nonatomic,strong)NSString *demand;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation SearchNumbersViewController
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
    NSArray *pickerArr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dic in pickerArr) {
        
        NSMutableArray *citys=[NSMutableArray array];
        for (NSDictionary *dict in dic[@"city"]) {
            [citys addObject:dict[@"name"]];
        }
        [self.dataArr addObject:@{@"province":dic[@"name"],@"city":citys}];
    }
    //NSLog(@"dataArr==%@",self.dataArr);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"寻找你的成员";
    self.project=@"";
    self.team=@"";
    self.demand=@"";
    self.province=@"";
    self.city=@"";
    
    [self.view addSubview:self.tableView];
    [self getData];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    if (self.isRevise) {
        //修改
        NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
        NSDictionary *param=@{@"teamId":@(self.teamId),@"user_token":user_token};
        
        [TDHttpTools teamInfoWithParams:param success:^(id response) {
            NSDictionary *dic=[SJTool dictionaryWithResponse:response];
            NSLog(@"%@",[SJTool logDic:dic]);
            if ([dic[@"code"] intValue]==200) {
                self.model=[[TeamEditModel alloc]initWithDictionary:dic[@"data"]];
                [self.tableView reloadData];
                self.project=self.model.project;
                self.team=self.model.team;
                self.demand=self.model.demand;
                self.province=self.model.province;
                self.city=self.model.city;
                self.catogaryID=self.model.categoryId;
            }else{
                [SJTool showAlertWithText:dic[@"msg"]];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
-(void)rightBarClick{
    NSString *user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    ApplySecondCell *cell0=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ApplySecondCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ApplySecondCell *cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (!cell0.textField.text.length) {
        [SJTool showAlertWithText:@"请填写标题"];
        return;
    }
    if (!cell1.textField.text.length) {
        [SJTool showAlertWithText:@"请填写姓名"];
        return;
    }
    if (!cell2.textField.text.length) {
        [SJTool showAlertWithText:@"请填写职位"];
        return;
    }
    if (!self.province.length || !self.city.length) {
        [SJTool showAlertWithText:@"请选择所在地"];
        return;
    }
    if (self.catogaryID==0) {
        [SJTool showAlertWithText:@"请选择行业分类"];
        return;
    }
    if (!self.project.length) {
        [SJTool showAlertWithText:@"请填写项目介绍"];
        return;
    }
    if (!self.team.length) {
        [SJTool showAlertWithText:@"请填写团队介绍"];
        return;
    }
    NSDictionary *param=@{@"id":@(self.teamId),@"user_token":user_token,@"title":cell0.textField.text,@"name":cell1.textField.text,@"job":cell2.textField.text,@"province":self.province,@"city":self.city,@"categoryId":@(self.catogaryID),@"project":self.project,@"team":self.team,@"demand":self.demand};
    
    [TDHttpTools submitTeamWithParams:param success:^(id response) {
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section==0) {
//        return 8;
//    }else{
//        return 2;
//    }
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
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
                    cell.topLab.text=@"标题";
                    cell.textField.placeholder=@"如新能源电池回收";
                    if (self.model) {
                        cell.textField.text=self.model.title;
                    }
                    cell.showCountLab.hidden=NO;
                    cell.textField.delegate=self;
                }else if(indexPath.row==1){
                    cell.topLab.text=@"姓名";
                    cell.textField.placeholder=@"请输入姓名";
                    if (self.model) {
                        cell.textField.text=self.model.name;
                    }
                }else{
                    cell.topLab.text=@"职位";
                    cell.textField.placeholder=@"例：***公司创始人&CEO";
                    if (self.model) {
                        cell.textField.text=self.model.job;
                    }
                }
                
                return cell;
            }
                break;
            case 3:
            case 4:
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
                    cell.topLab.text=@"地区";
                    if (self.model) {
                        cell.bottomLab.text=[NSString stringWithFormat:@"%@-%@",self.model.province,self.model.city];
                        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                    }else{
                        cell.bottomLab.text=@"请选择团队所在地";
                    }
                }else{
                    cell.topLab.text=@"行业分类";
                    if (self.model) {
                        cell.bottomLab.text=self.model.category;
                        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                    }else{
                        cell.bottomLab.text=@"请选择行业";
                    }
                }
                
                return cell;
            }
                break;
            case 5:
            case 6:
            case 7:
            {
                static NSString *cellId=@"cellIdentifier3";
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15); cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row==5) {
                    cell.textLabel.text=@"项目介绍";
                }else if (indexPath.row==6){
                    cell.textLabel.text=@"团队介绍";
                }else{
                    cell.textLabel.text=@"期望成员";
                }
                cell.textLabel.font=[UIFont systemFontOfSize:16];
                return cell;
            }
                break;
            default:
                break;
        }
    }
//    else{
//        NSString *cellID=@"cellIdentifie5";
//        ApplySecondCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//        if (cell==nil) {
//            cell=[[ApplySecondCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//            cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        }
//        switch (indexPath.row) {
//            case 0:
//                cell.topLab.text=@"联系人";
//                cell.textField.placeholder=@"请输入真实姓名";
//                break;
//            case 1:
//                cell.topLab.text=@"联系电话";
//                cell.textField.placeholder=@"请输入常用手机号";
//                cell.textField.keyboardType=UIKeyboardTypeNumberPad;
//                break;
//            default:
//                break;
//        }
//
//        return cell;
//    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0 && (indexPath.row==5 || indexPath.row==6 || indexPath.row==7)){
        return 44;
    }else{
        return 60;
    }
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *head=[[UIView alloc]init];
//    if (section==1) {
//        UITableViewHeaderFooterView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//        if (!header) {
//            header=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
//            header.contentView.backgroundColor=[UIColor whiteColor];
//            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 20)];
//            lab.font=[UIFont systemFontOfSize:12];
//            lab.textColor=[UIColor colorWithHexString:@"#989898"];
//            lab.text=@"以下内容将严格保密，不做展示";
//            [header addSubview:lab];
//        }
//        head=header;
//    }
//
//    return head;
//}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    view.tintColor=[UIColor whiteColor];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return 0.01;
//    }
//    return 20;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.01;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 3:
        {
            __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            WS(weakSelf);
            CustomCityPickerView *cityPicker=[[CustomCityPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) data:self.dataArr CompleteBlock:^(NSString * string) {
                
            }];
            [cityPicker setSureClickBlock:^(NSString * string) {
                cell.bottomLab.text=string;
                cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
                weakSelf.province=[string componentsSeparatedByString:@"-"].firstObject;
                weakSelf.city=[string componentsSeparatedByString:@"-"].lastObject;
            }];
            [cityPicker show];
        }
            break;
        case 4:
        {
            [self addCatogaryView];
        }
            break;
        case 5:
        {
            EditPageViewController *editVC=[EditPageViewController new];
            editVC.title=@"项目介绍";
            editVC.oldString=self.project;
            editVC.isIntro=NO;
            WS(weakSelf);
            [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                weakSelf.project=string;
            }];
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 6:
        {
            EditPageViewController *editVC=[EditPageViewController new];
            editVC.title=@"团队介绍";
            editVC.oldString=self.team;
            editVC.isIntro=NO;
            WS(weakSelf);
            [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                weakSelf.team=string;
            }];
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        case 7:
        {
            EditPageViewController *editVC=[EditPageViewController new];
            editVC.title=@"期望成员";
            editVC.oldString=self.demand;
            editVC.isIntro=YES;
            WS(weakSelf);
            [editVC setCallBackBlock:^(NSString * _Nonnull string) {
                weakSelf.demand=string;
            }];
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)addCatogaryView{
    NSDictionary *param=@{@"module":@"industry"};
    
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
    __block ApplyThirdCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    [self.catogaryView setSureBtnBlock:^(NSDictionary *dic) {
        cell.bottomLab.text=dic[@"name"];
        weakSelf.catogaryID=[dic[@"id"] intValue];
        cell.bottomLab.textColor=[UIColor colorWithHexString:@"#323232"];
    }];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    
    ApplySecondCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if ([textField isEqual:cell.textField]) {
        if (strLength > 15){
            return NO;
        }
        NSString *str=[NSString stringWithFormat:@"%d/15",(int)strLength];
        NSMutableAttributedString *attriStr=[[NSMutableAttributedString alloc]initWithString:str];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(str.length-2, 2)];
        cell.showCountLab.attributedText=attriStr;
    }
    
    
    return YES;
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
