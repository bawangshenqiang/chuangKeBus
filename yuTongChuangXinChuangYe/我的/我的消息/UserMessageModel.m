//
//  UserMessageModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "UserMessageModel.h"

@implementation UserMessageModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.photo=dic[@"photo"];
        self.nickname=dic[@"nickname"];
        self.create_time=dic[@"create_time"];
        self.title=dic[@"title"];
        self.targetId=[dic[@"targetId"] intValue];
        self.Id=[dic[@"id"] intValue];
        self.module=dic[@"module"];
    }
    return self;
}
@end
