//
//  Account.h
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/21.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property(nonatomic,copy)NSString *photo;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *descriptions;
/** 用户性别 -1-保密 0-男士 1-女士 */
@property(nonatomic,assign)int gender;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,assign)int provinceId;
@property(nonatomic,assign)int cityId;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *telephone;

@property(nonatomic,assign)int message;//消息数
/** 服务商状态 0-暂未加入 1-审核通过 2-审核中 */
@property(nonatomic,assign)int provider;
@property(nonatomic,assign)int providerId;
/** 微信绑定 */
@property(nonatomic,assign)BOOL wxbind;
/** 微信昵称 */
@property(nonatomic,copy)NSString *wxname;

+(Account *)sharedAccount;
-(void)logout;

@end
