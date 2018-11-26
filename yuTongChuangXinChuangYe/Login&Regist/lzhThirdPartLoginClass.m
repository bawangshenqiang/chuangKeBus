//
//  lzhThirdPartLoginClass.m
//  易彩票
//
//  Created by corill002 on 2018/1/8.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "lzhThirdPartLoginClass.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"

@implementation lzhThirdPartLoginClass

+ (void)initThirdPartyLogin:(AppDelegate*)app{
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeWechat)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeQQ:
                 //[ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class] delegate:app];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 //[ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"718730121"
                                           appSecret:@"ebfde7d2a2006bec0d8f572d4d6629cd"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106019665"
                                      appKey:@"ybjBCGP2HRvQs2m9"
                                    authType:SSDKAuthTypeBoth];
                 
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx6de68fd270d9c1c0" appSecret:@"6174ca9d3ebd39c1a37e87dad439651c" backUnionID:YES];
                 break;
             default:
                 break;
         }
     }];
}




@end
