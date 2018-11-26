//
//  CheckUpdateViewController.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CheckUpdateViewController.h"
#import "AFHTTPSessionManager.h"

@interface CheckUpdateViewController ()
@property(nonatomic,strong)UILabel *currentVersionLab;
@property(nonatomic,strong)UILabel *updateDateLab;
@property(nonatomic,strong)UILabel *newestVersionLab;
@property(nonatomic,strong)UILabel *lastUpdateLab;
@property(nonatomic,strong)UIButton *updateBtn;
@property(nonatomic,copy)NSString *latestVersionString;
@property(nonatomic,copy)NSString *itunesURLString;
@end

@implementation CheckUpdateViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"检查更新";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initSubView];
    
}
-(void)initSubView{
    UIImageView *leftIV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    leftIV.image=[UIImage imageNamed:@"update_yutong"];
    [self.view addSubview:leftIV];
    self.currentVersionLab=[[UILabel alloc]initWithFrame:CGRectMake(leftIV.right+15, 15, kScreenWidth-leftIV.right-30, 30)];
    self.currentVersionLab.font=[UIFont systemFontOfSize:18];
    self.currentVersionLab.textColor=[UIColor colorWithHexString:@"#323232"];
    self.currentVersionLab.text=[NSString stringWithFormat:@"当前版本：%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [self.view addSubview:self.currentVersionLab];
    self.updateDateLab=[[UILabel alloc]initWithFrame:CGRectMake(self.currentVersionLab.left, self.currentVersionLab.bottom, self.currentVersionLab.width, 20)];
    self.updateDateLab.font=[UIFont systemFontOfSize:15];
    self.updateDateLab.textColor=[UIColor colorWithHexString:@"#989898"];
    self.updateDateLab.text=@"发布日期：";
    [self.view addSubview:self.updateDateLab];
    self.newestVersionLab=[[UILabel alloc]initWithFrame:CGRectMake(10, leftIV.bottom+30, kScreenWidth-20, 20)];
    self.newestVersionLab.font=[UIFont systemFontOfSize:20];
    self.newestVersionLab.textColor=[UIColor colorWithHexString:@"#323232"];
    self.newestVersionLab.text=@"已更新至最新版本";
    [self.view addSubview:self.newestVersionLab];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, self.newestVersionLab.bottom+10, kScreenWidth-20, 0.5)];
    line.backgroundColor=RGBAColor(145, 165, 165, 1);
    [self.view addSubview:line];
    UILabel *lastUpdate=[[UILabel alloc]initWithFrame:CGRectMake(10, line.bottom+20, 100, 20)];
    lastUpdate.text=@"最近更新";
    lastUpdate.textColor=kThemeColor;
    lastUpdate.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:lastUpdate];
    self.lastUpdateLab=[[UILabel alloc]initWithFrame:CGRectMake(10, lastUpdate.bottom, kScreenWidth-20, 250)];
    self.lastUpdateLab.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:self.lastUpdateLab];
    self.updateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.updateBtn.frame=CGRectMake(60, self.lastUpdateLab.bottom+10, kScreenWidth-120, 45);
    [self.updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [self.updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.updateBtn.backgroundColor=kThemeColor;
    self.updateBtn.layer.cornerRadius=5;
    self.updateBtn.layer.masksToBounds=YES;
    [self.updateBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.updateBtn];
    //
    [self checkAppStore];
}

-(void)updateBtnClick:(UIButton *)btn{
    
    if ([self compareVersionsFormAppStore:self.latestVersionString AppVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]) {
        
        NSURL * url = [NSURL URLWithString:self.itunesURLString];
        
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"+++");
    }else{
        NSLog(@"---");
    }
}

-(void)checkAppStore{
    NSString *urlString=@"http://itunes.apple.com/cn/lookup?id=1411238056";
    [SVProgressHUD showWithStatus:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",@"application/xhtml+xml",@"application/xml", nil];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        id nodic=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([nodic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict=(NSDictionary *)nodic;
            /**
             {
             resultCount = 0;
             results =     (
             );
             }
             */
            NSArray *array = dict[@"results"];
            NSDictionary *dic = [array lastObject];
            NSString *versionStr = [dic objectForKey:@"version"];
            NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
            NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
            self.latestVersionString=versionStr;
            self.itunesURLString=trackViewUrl;
            self.lastUpdateLab.text=releaseNotes;
            NSString *thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            NSLog(@"%@,当前版本:%@",dict,thisVersion);
            if (versionStr.length) {
                if ([self compareVersionsFormAppStore:versionStr AppVersion:thisVersion]) {
                    self.newestVersionLab.text=[NSString stringWithFormat:@"发现新版本:%@",versionStr];
                    [self.updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
                    
                }else{
                    self.newestVersionLab.text=@"已更新至最新版本";
                    [self.updateBtn setTitle:@"已是最新版本" forState:UIControlStateNormal];
                    
                }
            }else{
                self.latestVersionString=@"0.0";
                self.itunesURLString=@"";
                self.newestVersionLab.text=@"已更新至最新版本";
                [self.updateBtn setTitle:@"已是最新版本" forState:UIControlStateNormal];
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [SVProgressHUD showErrorWithStatus:@"查询失败！" ];
            }
        }else{
            
            self.latestVersionString=@"0.0";
            self.itunesURLString=@"";
            self.newestVersionLab.text=@"已更新至最新版本";
            [self.updateBtn setTitle:@"已是最新版本" forState:UIControlStateNormal];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [SVProgressHUD showErrorWithStatus:@"查询失败！" ];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        self.latestVersionString=@"0.0";
        self.itunesURLString=@"";
        self.newestVersionLab.text=@"已更新至最新版本";
        [self.updateBtn setTitle:@"已是最新版本" forState:UIControlStateNormal];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"查询失败！" ];
        
    }];
}
//这个方法有问题？？？
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion AppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
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
