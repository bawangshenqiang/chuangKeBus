//
//  AppDelegate.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "InformationFirstViewController.h"
#import "ServeFirstViewController.h"
#import "HallFirstViewController.h"
#import "HuaShanFightViewController.h"
#import "MyInfoViewController.h"
#import "RDVTabBarItem.h"

#import "LLFullScreenAdView.h"

#import <AVFoundation/AVFoundation.h>

#import "lzhThirdPartLoginClass.h"
#import "WXApi.h"

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

/** 接收到消息的标记 */
extern BOOL receiveMessage;
/** 推送设置里面的开关控制 */
BOOL receiveComment;
BOOL receivePraise;
BOOL collected;

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate

static NSString *appKey = @"786ccf4ff91944dd7f2970c2";
static NSString *channel = @"";//@"Ad Hoc",@"App Store";
static BOOL isProduction = NO;//YES//NO

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window makeKeyAndVisible];
    
    [self addADView];       // 添加广告图
    [self getADImageURL];
    
    //
    [self customNaviBar];
    
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    //控制推送设置
    NSArray *pushArr=[[NSUserDefaults standardUserDefaults] objectForKey:@"pushArr"];
    if (pushArr==nil) {
        NSMutableArray *mutaArr=[NSMutableArray arrayWithObjects:@"comment",@"praise",@"collect", nil];
        [[NSUserDefaults standardUserDefaults] setObject:mutaArr forKey:@"pushArr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSArray *arr=[[NSUserDefaults standardUserDefaults] objectForKey:@"pushArr"];
    if ([arr containsObject:@"comment"]) {
        receiveComment=YES;
    }else{
        receiveComment=NO;
    }
    if ([arr containsObject:@"praise"]) {
        receivePraise=YES;
    }else{
        receivePraise=NO;
    }
    if ([arr containsObject:@"collect"]) {
        collected=YES;
    }else{
        collected=NO;
    }
    
    //极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionNone|JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            //[SJTool showAlertWithText:@"成功"];
            //NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"RegistID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
        //uid: 15780924909
        //registrationID:1114a89792817d226ec
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    //极光自定义消息必须实现
    //NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    //[defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    // iOS 10以下，杀死应用后重新进入程序
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification ==nil) {
        //1.点击icon进入应用
        
    }else{
        //2.点击通知消息进入应用
        receiveMessage=YES;
        if ([remoteNotification[@"module"] isEqualToString:@""]) {
            
        }
    }
    
    
    
    
    
    [lzhThirdPartLoginClass initThirdPartyLogin:self];
    
    
    return YES;
}
/** 添加广告图 */
- (void)addADView
{
    LLFullScreenAdView *adView = [[LLFullScreenAdView alloc] init];
    adView.tag = 10;
    adView.duration = 3;
    adView.waitTime = 3;//经测试，此处的时间需要大于网络请求的时间，否则广告页不显示
    adView.skipType = SkipButtonTypeCircleAnimationTest;//圆形的动画跳过
    adView.adImageTapBlock = ^(NSString *content) {
        NSLog(@"%@", content);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    };
    
    [self.window addSubview:adView];
}

/** 获取广告图URL */
- (void)getADImageURL
{
    // 此处推荐使用tag来获取adView，勿使用全局变量。因为在AppDelegate中将其设为全局变量时，不会被释放
    LLFullScreenAdView *adView = (LLFullScreenAdView *)[self.window viewWithTag:10];
    
    // 模拟从服务器上获取广告图URL
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *urlString = @"http://s8.mogucdn.com/p2/170223/28n_4eb3la6b6b0h78c23d2kf65dj1a92_750x1334.jpg";
        
        [adView reloadAdImageWithUrl:urlString]; // 加载广告图
    });
    /**
    NSDictionary *param=@{@"module":@"project"};
    [TDHttpTools getCatogaryWithParams:param success:^(id response) {
        NSDictionary *dic=[SJTool dictionaryWithResponse:response];
        NSLog(@"%@",[SJTool logDic:dic]);
        
        if ([dic[@"code"] intValue]==200) {
            NSString *url=dic[@"data"][@"url"];
            if (url.length) {
               [adView reloadAdImageWithUrl:url]; // 加载广告图
            }
        }else{
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    */
}
//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    NSString *path = [url absoluteString];
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", path);
    
    return [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    NSString *path = [url absoluteString];
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"%@", path);
    //file:///private/var/mobile/Containers/Data/Application/09047F64-02D3-496A-B12D-2E03B2656C3E/Documents/Inbox/副本-公众号-1.pdf
    //file:///private/var/mobile/Containers/Data/Application/09047F64-02D3-496A-B12D-2E03B2656C3E/Documents/Inbox/公众号.pdf
    //file:///private/var/mobile/Containers/Data/Application/09047F64-02D3-496A-B12D-2E03B2656C3E/Documents/Inbox/anti.zip
    
    //UploadPlanFileViewController
    [kNotificationCenter postNotificationName:@"receivePlanfile" object:nil userInfo:@{@"path":path}];
    
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)setupViewControllers{
    
    
    InformationFirstViewController *homeVC=[[InformationFirstViewController alloc]init];
    UINavigationController *homeNavi=[[UINavigationController alloc]initWithRootViewController:homeVC];
    
    ServeFirstViewController *openLotteryVC = [[ServeFirstViewController alloc] init];
    UINavigationController *openLotteryNavi=[[UINavigationController alloc]initWithRootViewController:openLotteryVC];
    
    HallFirstViewController *hallVC=[[HallFirstViewController alloc]init];
    UINavigationController *hallNavi=[[UINavigationController alloc]initWithRootViewController:hallVC];
    
    HuaShanFightViewController *guessHappyVC=[[HuaShanFightViewController alloc]init];
    UINavigationController *guessHappyNavi=[[UINavigationController alloc]initWithRootViewController:guessHappyVC];
    
    MyInfoViewController *userInfoVC = [[MyInfoViewController alloc] init];
    UINavigationController *userInfoNavi=[[UINavigationController alloc]initWithRootViewController:userInfoVC];
    
    
    
    self.tabBarController = [[RDVTabBarController alloc] init];
    
    [self.tabBarController setViewControllers:@[homeNavi,openLotteryNavi,hallNavi,guessHappyNavi,userInfoNavi]];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.4)];
    line.backgroundColor=RGBAColor(165, 165, 165, 0.5);
    [[self.tabBarController tabBar].backgroundView addSubview:line];
    [self.tabBarController tabBar].backgroundView.backgroundColor=[UIColor whiteColor];
    self.tabBarController.selectedIndex=2;
    [self customizeTabBarForController:self.tabBarController];
    self.window.rootViewController=self.tabBarController;
}
- (void)displayLoginVC{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNavi=[[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController=loginNavi;
}


-(void)customizeTabBarForController:(RDVTabBarController *)tabBarController{
    
    if (IsIphoneX_series) {
        [tabBarController.tabBar setHeight:83];
    }else{
        [tabBarController.tabBar setHeight:49];
    }
    
    
    //UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"hall_information", @"hall_serve", @"hall_hall",@"hall_huashan",@"hall_mine"];
    NSArray *tabBarItemTitles = @[@"资讯", @"服务",@"大厅",@"华山论剑",@"我的"];
    NSDictionary *unSelectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                    NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#989898"]};
    NSDictionary *selectedTitle=@{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#068ee1"]};
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //[item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.unselectedTitleAttributes=unSelectedTitle;
        item.selectedTitleAttributes=selectedTitle;
        
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        
        index++;
    }
    
    
    
}

-(void)customNaviBar{
    
    NSDictionary *textAttributes = @{
                                     
                                     NSFontAttributeName : [UIFont systemFontOfSize:20],
                                     
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     
                                     };//[UIColor blackColor]
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    //返回按钮的箭头颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //导航栏的背景色
    [[UINavigationBar appearance] setBarTintColor:kThemeColor];//kThemeColor//[UIColor whiteColor]
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //调整返回按钮当中文字的位置.（我们只要返回按钮的那个图片，但是不要上面的文字，移走文字就好了）
    //UIBarButtonItem *item = [UIBarButtonItem appearance];
    //[item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -(kStatusBarHeight+44)) forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    
    //去掉下边的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //状态条白色字体
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//极光自定义消息必须实现
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
//    NSString *customizeField1 = [extras valueForKey:@"module"]; //服务端传递的 Extras 附加字段，key 是自己定义的
//    NSLog(@"Extras 附加字段:module=%@",customizeField1);
//}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(12.0)){
    
    receiveMessage=YES;
    
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
        
    }else{
        //从通知设置界面进入应用
        
    }
    
    [JPUSHService resetBadge];
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        
        //RDVTabBarController *rdvVC=(RDVTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        //UINavigationController *selectVC =(UINavigationController *)rdvVC.selectedViewController;
        
        receiveMessage=YES;
        
        if([Account sharedAccount]){
            [Account sharedAccount].message++;
        }
        
    }
    completionHandler(UNNotificationPresentationOptionSound);
    [JPUSHService resetBadge];
}

// iOS 10 Support
/// 程序运行于前台，后台 或杀死 点击推送通知 都会走这个方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        receiveMessage=YES;
        
        NSArray *pushArr=[[NSUserDefaults standardUserDefaults] objectForKey:@"pushArr"];
        if([userInfo[@"module"] isEqualToString:@"comment"]&&[pushArr containsObject:@"comment"]){
        }
        if([userInfo[@"module"] isEqualToString:@"praise"]&&[pushArr containsObject:@"praise"]){
        }
        if([userInfo[@"module"] isEqualToString:@"collect"]&&[pushArr containsObject:@"collect"]){
        }
    }
    
    [JPUSHService resetBadge];
    
    completionHandler();  // 系统要求执行这个方法
    
//    {
//        "_j_business" = 1;
//        "_j_msgid" = 9007199992917938;
//        "_j_uid" = 15780924909;
//        aps =     {
//            alert = "\U6d4b\U8bd5222";
//            badge = 1;
//            sound = default;
//        };
//        module = project;
//    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0) {
        NSLog(@"iOS 7以上 10以下 系统收到通知:%@", [SJTool logDic:userInfo]);
        
        receiveMessage=YES;
        if (application.applicationState==UIApplicationStateActive) {
            // iOS 10以下，前台
            
        }else{
            // iOS 10以下，后台，且进程未终结
            
        }
        if([Account sharedAccount]){
            [Account sharedAccount].message++;
        }
        
    }
    
    [JPUSHService resetBadge];
    
    completionHandler(UIBackgroundFetchResultNewData);
}


@end
