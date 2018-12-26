//
//  ServerDetailViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServerDetailViewController.h"
#import "SubmitServeNeedViewController.h"
#import "LoginViewController.h"
#import "JoinServerViewController.h"

@interface ServerDetailViewController ()
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *bottomBtn;
@property(nonatomic,assign)BOOL collected;//是否收藏
@property(nonatomic,assign)BOOL editable;//是否是自己的
@property(nonatomic,assign)int status;//1审核通过 非1审核不通过
@property(nonatomic,strong)NSString *serverName;//服务商名称
@property(nonatomic,strong)NSString *categoryName;//分类
@property(nonatomic,assign)BOOL demand;//用户是否可以提交需求
@end

@implementation ServerDetailViewController

-(void)getUrlData:(NSString *)url{
    NSString *path = url;//@"https://www.jianshu.com/p/f31e39d3ce41"
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [self.webView loadRequest:request];
}
-(void)getData{
    
    NSString *timestamp=[SJTool getNowTimeTimestamp3];
    NSString *access_token=[SJTool getToken];
    NSString *user_token=@"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]!=nil) {
        user_token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    }
    NSDictionary *param=@{@"timestamp":timestamp,@"access_token":access_token,@"user_token":user_token,@"providerId":@(self.providerId)};
    [TDHttpTools providerDeatilWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            
            [self getUrlData:dic[@"data"][@"url"]];
            self.collected=[dic[@"data"][@"collected"] boolValue];
            [self.collectBtn setSelected:self.collected];
            self.status=[dic[@"data"][@"status"] intValue];
            self.serverName=dic[@"data"][@"title"];
            self.categoryName=dic[@"data"][@"category"];
            self.demand=[dic[@"data"][@"demand"] boolValue];
            self.editable=[dic[@"data"][@"editable"] boolValue];
//            if (self.editable) {
//                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
//            }else{
//                self.navigationItem.rightBarButtonItem=nil;
//
//            }
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //
    [self getData];
}
-(void)rightBarClick{
    JoinServerViewController *joinVC=[JoinServerViewController new];
    //joinVC.isRevise=YES;
    //joinVC.Id=self.providerId;
    [self.navigationController pushViewController:joinVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务商详情";
    self.view.backgroundColor=kBackgroundColor;
    self.serverName=@"";
    self.categoryName=@"";
    
    [self.view addSubview:self.webView];
    
    
    //
    self.collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame=CGRectMake(0, self.webView.bottom, kScreenWidth/2, 40);//CGRectMake(kScreenWidth-75, 40, 60, 30)
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
//    [self.collectBtn setImage:[UIImage imageNamed:@"introduction_collect"] forState:UIControlStateNormal];
//    [self.collectBtn setImage:[UIImage imageNamed:@"introduction_collect_nor"] forState:UIControlStateSelected];
    self.collectBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.collectBtn setTitleColor:[UIColor colorWithHexString:@"989898"] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.collectBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.collectBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ff973e"]] forState:UIControlStateSelected];
    self.collectBtn.layer.borderColor=[UIColor colorWithHexString:@"ff973e"].CGColor;
    self.collectBtn.layer.borderWidth=0.5;
    self.collectBtn.selected=NO;
    [self.collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.collectBtn];
    //
    self.bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn.frame=CGRectMake(self.collectBtn.right, self.webView.bottom, kScreenWidth/2, 40);//CGRectMake(50, self.webView.bottom-60, kScreenWidth-100, 40);
    [self.bottomBtn setTitle:@"提交需求" forState:UIControlStateNormal];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomBtn.backgroundColor=kThemeColor;
    self.bottomBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
//    self.bottomBtn.layer.cornerRadius=5;
//    self.bottomBtn.layer.shadowColor=kThemeColor.CGColor;
//    self.bottomBtn.layer.shadowRadius=4;
//    self.bottomBtn.layer.shadowOpacity=0.5;
//    self.bottomBtn.layer.shadowOffset=CGSizeMake(0, 2);
    [self.bottomBtn addTarget:self action:@selector(bottomClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomBtn];
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTableViewHeight-40)];
        
        [self.view addSubview:_webView];
    }
    return _webView;
}
-(void)collectClick{
    if (self.editable) {
        [SJTool showAlertWithText:@"不能收藏自己的"];
        return;
    }
    if (self.status!=1) {
        [SJTool showAlertWithText:@"正在审核中"];
        return;
    }
    
    
    if ([Account sharedAccount]==nil) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNavi animated:YES completion:nil];
    }else{
        [self collectAProvider];
    }
    
}
-(void)collectAProvider{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    if (token==nil) {
        token=@"";
    }
    NSDictionary *param=@{@"user_token":token,@"providerId":@(self.providerId)};
    [TDHttpTools collectProviderWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        if ([dic[@"code"] intValue]==200) {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
            
            self.collectBtn.selected=!self.collectBtn.isSelected;
        }else{
            [SJTool showAlertWithText:dic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)bottomClick{
    if (self.editable) {
        [SJTool showAlertWithText:@"自己的不能提交需求"];
        return;
    }
    if (self.status!=1) {
        [SJTool showAlertWithText:@"正在审核中"];
        return;
    }
    if (!self.demand) {
        [SJTool showAlertWithText:@"请先提交一个项目"];
        return;
    }
    if (!self.serverName.length || !self.categoryName.length) {
        return;
    }
    if ([Account sharedAccount]==nil) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:loginNavi animated:YES completion:nil];
    }else{
        SubmitServeNeedViewController *submitVC=[SubmitServeNeedViewController new];
        submitVC.providerId=self.providerId;
        submitVC.serverName=self.serverName;
        submitVC.categoryName=self.categoryName;
        [self.navigationController pushViewController:submitVC animated:YES];
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
