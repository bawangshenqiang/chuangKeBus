//
//  SetViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SetViewController.h"
#import "ClearCacheCell.h"
#import "LogoutCell.h"
#import "UserInfomationViewController.h"
#import "SJAlertView.h"
#import "ChangeLoginPWDViewController.h"
#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "BindingAccountViewController.h"
#import "PushMessageViewController.h"
#import "JPUSHService.h"
#import "SystemTableViewCell.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)SJAlertView *alertView;

@end

@implementation SetViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled=NO;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if (section==1){
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellId=@"cellIdentifier";
            SystemTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[SystemTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            NSArray *arr=@[@"个人资料",@"修改密码",@"微信绑定"];
            cell.textLabel.text=arr[indexPath.row];
            if (indexPath.row==2) {
                cell.separatorLine.hidden=YES;
            }
            return cell;
        }
            break;
        case 1:
        {
            if (indexPath.row==0) {
                NSString *cellId=@"cellIdentifier";
                SystemTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell=[[SystemTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
                
                cell.textLabel.text=@"推送提醒";
                return cell;
            }else{
                ClearCacheCell *cell=[[ClearCacheCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                NSString *cashStr=[SJTool cacheSizeStr:[SJTool getSize]];
                if (cashStr.length>4) {
                    cashStr=[cashStr substringFromIndex:4];
                }else{
                    cashStr=@"";
                }
                cell.contentLab.text=cashStr;
                return cell;
            }
        }
            break;
        default:
        {
            LogoutCell *cell=[[LogoutCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            return cell;
        }
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1 && indexPath.row==1) {
        return 60;
    }
    if (indexPath.section==2) {
        return 50;
    }
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                if ([Account sharedAccount]==nil) {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                    [self presentViewController:loginNavi animated:YES completion:nil];
                }else{
                    UserInfomationViewController *userVC=[UserInfomationViewController new];
                    [self.navigationController pushViewController:userVC animated:YES];
                }
                
            }else if (indexPath.row==1){
                if ([Account sharedAccount]==nil) {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                    [self presentViewController:loginNavi animated:YES completion:nil];
                }else{
                    ChangeLoginPWDViewController *changeVC=[ChangeLoginPWDViewController new];
                    [self.navigationController pushViewController:changeVC animated:YES];
                }
                
            }else{
                //微信绑定
                if ([Account sharedAccount]==nil) {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                    [self presentViewController:loginNavi animated:YES completion:nil];
                }else{
                    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
                           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
                     {
                         if (state == SSDKResponseStateSuccess)
                         {
                             
                             
                             //
                             NSString *CName=[user.nickname copy];
                             NSString *icon = [user.icon copy];
                             
                             //
                             WS(weakSelf);
                             [weakSelf thirdPartyLogin:user.uid cName:CName headImg:icon];
                         }
                         
                         else
                         {
                             NSLog(@"%@",error);
                         }
                         
                     }];
                }
            }
            break;
        case 1:
            if (indexPath.row==0) {
                //推送提醒
                if ([Account sharedAccount]==nil) {
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                    [self presentViewController:loginNavi animated:YES completion:nil];
                }else{
                    PushMessageViewController *pushVC=[PushMessageViewController new];
                    [self.navigationController pushViewController:pushVC animated:YES];
                }
            }else{
                //清除缓存
                if ([SJTool getSize]>0) {
                    NSString *cashStr=[SJTool cacheSizeStr:[SJTool getSize]];
                    [SVProgressHUD showWithStatus:cashStr];
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SJTool clearFile];
                        [SVProgressHUD dismiss];
                    });
                }else{
                    [SJTool showAlertWithText:@"数据缓存已清空"];
                }
                ClearCacheCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                cell.contentLab.text=@"";
            }
            break;
        default:
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]==nil || [[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"] isEqualToString:@""]) {
                return;
            }
            self.alertView=[[SJAlertView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
            self.alertView.topLab.text=@"退出登录";
            self.alertView.detailLab.text=@"确认要退出当前账号?";
            [self.alertView setSureBtnBlock:^{
                NSLog(@"点击确认");
                [[Account sharedAccount] logout];
                //退出登录时把别名删除
                [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    if (iResCode==0) {
                        NSLog(@"极光清除别名成功");
                    }else{
                        NSLog(@"极光清除别名失败");
                    }
                } seq:2];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TOKEN"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SJTool showAlertWithText:@"已退出登录"];
            }];
            break;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=kBackgroundColor;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)thirdPartyLogin:(NSString*)openId cName:(NSString *)cname headImg:(NSString *)headImg{
    
    NSDictionary *param=@{@"openid":openId,@"ip":@""};
    [TDHttpTools loginWXWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        //NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:@"已绑定微信"];
        }else if ([dic[@"code"] intValue]==500301){
            //未绑定
            BindingAccountViewController *bingVC=[BindingAccountViewController new];
            bingVC.openid=openId;
            bingVC.fromSetPage=YES;
            [self.navigationController pushViewController:bingVC animated:YES];
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
