//
//  Account.m
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/21.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "Account.h"

@implementation Account

static Account *_account;

+(Account *)sharedAccount{
    
    @synchronized(self) {
        if (!_account) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kAccountPath];
            
            if ([dic allKeys].count) {
                _account = [[Account alloc]init];
                _account.photo=dic[@"photo"];
                _account.nickname=dic[@"nickname"];
                _account.name=dic[@"name"];
                _account.descriptions =dic[@"description"];
                _account.birthday=dic[@"birthday"];
                _account.province=dic[@"province"];
                _account.city=dic[@"city"];
                _account.telephone=dic[@"telphone"];
                _account.gender=[dic[@"gender"] intValue];
                _account.provinceId=[dic[@"provinceId"] intValue];
                _account.cityId=[dic[@"cityId"] intValue];
                _account.message=[dic[@"message"] intValue];
                _account.provider=[dic[@"provider"] intValue];
                _account.providerId=[dic[@"providerId"] intValue];
                _account.wxbind=[dic[@"wxbind"] boolValue];
                _account.wxname=dic[@"wxname"];
            }
            
        }
    }
    
    
    return _account;
}
-(void)logout{
    //NSLog(@"退出登录");
    //删除文件
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:kAccountPath error:nil];
    
    //清空NSUserDefaults下的内容
//    NSString*appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    //清除缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    _account = nil;
    //[PDKeyChain keyChainSave:@""];
    
}

@end
