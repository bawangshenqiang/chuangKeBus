//
//  InterestModel_Public.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InterestModel_Public : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int findTeamUserId;//团队ID
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *linker;
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,strong)NSString *descriptions;//个人简介
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,assign)BOOL showAll;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
