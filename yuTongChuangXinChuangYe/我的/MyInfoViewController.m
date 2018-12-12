//
//  MyInfoViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "MyInfoViewController.h"
#import "TopView_MyInfo.h"
#import "SetViewController.h"
#import "CheckUpdateViewController.h"
#import "AboutWeViewController.h"
#import "SuggestionsFeedbackViewController.h"
#import "MyChuangYeViewController.h"
#import "MyCollectionViewController.h"
#import "MyPublishViewController.h"
#import "MyMessageViewController.h"
#import "JoinServerViewController.h"
#import "LoginViewController.h"
#import "SystemTableViewCell.h"
#import "HatchPersonViewController.h"
#import "UserInfomationViewController.h"
#import "TastCenterViewController.h"

extern BOOL receiveMessage;

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TopView_MyInfo *topView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MyInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self getUserInfro];
    
    [self.topView.headerIV sd_setImageWithURL:[NSURL URLWithString:[Account sharedAccount].photo] placeholderImage:[UIImage imageNamed:@"mine_user"]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]==nil || [[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"] isEqualToString:@""]) {
        self.topView.nameLab.text=@"登录/注册";
        self.topView.mesCountLab.hidden=YES;
    }else{
        self.topView.nameLab.text=[Account sharedAccount].nickname;
        if ([Account sharedAccount].message>0) {
            self.topView.mesCountLab.hidden=NO;
            self.topView.mesCountLab.text=[NSString stringWithFormat:@"%d",[Account sharedAccount].message];
        }else{
            self.topView.mesCountLab.hidden=YES;
        }
    }
    
}
//获取个人信息
-(void)getUserInfro{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token};
    [TDHttpTools getUserInfoWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [Account sharedAccount].message=[dic[@"data"][@"message"] intValue];
            [Account sharedAccount].photo=dic[@"data"][@"photo"];
            [Account sharedAccount].nickname=dic[@"data"][@"nickname"];
            [Account sharedAccount].provider=[dic[@"data"][@"provider"] boolValue];
            [self.topView.headerIV sd_setImageWithURL:[NSURL URLWithString:[Account sharedAccount].photo] placeholderImage:[UIImage imageNamed:@"mine_user"]];
            
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TOKEN"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[Account sharedAccount] logout];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    
    self.topView=[[TopView_MyInfo alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight+275)];
    
    //[self getUserInfro];
    
    [self.view addSubview:self.topView];
    
    WS(weakSelf);
    [self.topView setSetClickedBlock:^{
        //设置
        SetViewController *setVC=[SetViewController new];
        [weakSelf.navigationController pushViewController:setVC animated:YES];
    }];
    [self.topView setLoginClickBlock:^{
        //登录
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            UserInfomationViewController *userinfroVC=[UserInfomationViewController new];
            [weakSelf.navigationController pushViewController:userinfroVC animated:YES];
        }
    }];
    [self.topView setHeaderClickBlock:^{
        //头像
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            UserInfomationViewController *userinfroVC=[UserInfomationViewController new];
            [weakSelf.navigationController pushViewController:userinfroVC animated:YES];
        }
    }];
    [self.topView setFourBtnClickBlock:^(NSInteger index) {
        //NSLog(@"tag:%d",(int)index);
        //我的创业
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            MyChuangYeViewController *myChuangyeVC=[MyChuangYeViewController new];
            myChuangyeVC.index=index-800;
            [weakSelf.navigationController pushViewController:myChuangyeVC animated:YES];
        }
    }];
    [self.topView setThreeBtnClickBlock:^(NSInteger index) {
        //NSLog(@"tag:%d",(int)index);
        if ([Account sharedAccount]==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
            [weakSelf presentViewController:loginNavi animated:YES completion:nil];
        }else{
            switch (index-900) {
                case 0:
                {//我的收藏
                    MyCollectionViewController *collectVC=[MyCollectionViewController new];
                    collectVC.index=0;
                    [weakSelf.navigationController pushViewController:collectVC animated:YES];
                }
                    break;
                case 1:
                {//我的发表
                    MyPublishViewController *publishVC=[MyPublishViewController new];
                    publishVC.index=0;
                    [weakSelf.navigationController pushViewController:publishVC animated:YES];
                }
                    break;
                case 2:
                {//我的消息
                    [Account sharedAccount].message=0;
                    weakSelf.topView.mesCountLab.hidden=YES;
                    receiveMessage=NO;
                    MyMessageViewController *messageVC=[MyMessageViewController new];
                    messageVC.index=0;
                    [weakSelf.navigationController pushViewController:messageVC animated:YES];
                }
                    break;
                default:
                {//任务中心
                    TastCenterViewController *centerVC=[TastCenterViewController new];
                    [weakSelf.navigationController pushViewController:centerVC animated:YES];
                }
                    break;
            }
        }
        
        
    }];
    
    //
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(10, self.topView.bottom+10, kScreenWidth-20, 176) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled=NO;
        _tableView.tableFooterView=[UIView new];
        _tableView.layer.cornerRadius=5;
        _tableView.layer.masksToBounds=YES;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId=@"cellIdentifier";
    SystemTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[SystemTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *arr=@[@"加入服务商",@"检查更新",@"关于我们",@"建议反馈"];
    cell.titleLab.text=arr[indexPath.row];
    if (indexPath.row==arr.count-1) {
        cell.separatorLine.hidden=YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
//        case 0:
//        {
//            if ([Account sharedAccount]==nil) {
//                LoginViewController *loginVC = [[LoginViewController alloc]init];
//                UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
//                [self presentViewController:loginNavi animated:YES completion:nil];
//            }else{
//                HatchPersonViewController *hatchVC=[HatchPersonViewController new];
//                [self.navigationController pushViewController:hatchVC animated:YES];
//            }
//        }
//            break;
        case 0:
        {
            if ([Account sharedAccount]==nil) {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:loginNavi animated:YES completion:nil];
            }else{
                if ([Account sharedAccount].provider) {
                    //给服务商展示的沟通列表
                    
                }else{
                    JoinServerViewController *joinVC=[JoinServerViewController new];
                    [self.navigationController pushViewController:joinVC animated:YES];
                }
                
            }
            
        }
            break;
        case 1:
        {
            CheckUpdateViewController *checkVC=[CheckUpdateViewController new];
            [self.navigationController pushViewController:checkVC animated:YES];
        }
            break;
        case 2:
        {
            AboutWeViewController *aboutVC=[AboutWeViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        default:
        {
            if ([Account sharedAccount]==nil) {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:loginNavi animated:YES completion:nil];
            }else{
                SuggestionsFeedbackViewController *suggestVC=[SuggestionsFeedbackViewController new];
                [self.navigationController pushViewController:suggestVC animated:YES];
            }
        }
            break;
    }
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
