//
//  SubmitServeNeedViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SubmitServeNeedViewController.h"
#import "SectionHeader_HallFirst.h"
#import "ApplySecondCell.h"
#import "SingleTextViewCell.h"

@interface SubmitServeNeedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SubmitServeNeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交服务需求";
    self.view.backgroundColor=kBackgroundColor;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    [self.view addSubview:self.tableView];
}
-(void)rightBarClick{
    SingleTextViewCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (!cell1.textView.text.length) {
        [SJTool showAlertWithText:@"请填写需求"];
        return;
    }
    ApplySecondCell *cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (!cell2.textField.text.length) {
        [SJTool showAlertWithText:@"请输入联系人"];
        return;
    }
    ApplySecondCell *cell3=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    if (!cell3.textField.text.length) {
        [SJTool showAlertWithText:@"请输入联系电话"];
        return;
    }
    
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"providerId":@(self.providerId),@"demand":cell1.textView.text,@"linker":cell2.textField.text,@"linkphone":cell3.textField.text};
    [TDHttpTools providerDemandWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
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
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellID=@"cellIdentifier1";
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            if (indexPath.row==0) {
                cell.textLabel.text=@"服务商";
                cell.detailTextLabel.text=self.serverName;
            }else{
                cell.textLabel.text=@"服务类型";
                cell.detailTextLabel.text=self.categoryName;
            }
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellID=@"cellIdentifier2";
            SingleTextViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell=[[SingleTextViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
                cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 1000);
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.placeHolderLabel.text=@"请详细描述对该服务的需求";
            return cell;
        }
            break;
        default:
        {
            NSString *cellID=@"cellIdentifier3";
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
                    if ([Account sharedAccount]) {
                        cell.textField.text=[Account sharedAccount].name;
                    }
                    break;
                case 1:
                    cell.topLab.text=@"联系电话";
                    cell.textField.placeholder=@"请输入常用手机号";
                    cell.textField.keyboardType=UIKeyboardTypeNumberPad;
                    if ([Account sharedAccount]) {
                        cell.textField.text=[Account sharedAccount].telephone;
                    }
                    break;
                default:
                    break;
            }
            
            return cell;
        }
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return 100;
    }
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeader_HallFirst *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header=[[SectionHeader_HallFirst alloc]initWithReuseIdentifier:@"header"];
        header.contentView.backgroundColor=[UIColor whiteColor];
    }
    NSArray *images=@[@"demand_select",@"demand_instructions",@"serviceproviders_contact"];
    NSArray *titles=@[@"当前选择",@"需求说明",@"联系方式"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
