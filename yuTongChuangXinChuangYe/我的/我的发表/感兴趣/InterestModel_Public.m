//
//  InterestModel_Public.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InterestModel_Public.h"

@implementation InterestModel_Public
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.findTeamUserId=[dic[@"findTeamUserId"] intValue];
        self.title=dic[@"title"];
        self.photo=dic[@"photo"];
        self.nickname=dic[@"nickname"];
        self.create_time=dic[@"create_time"];
    }
    return self;
}
@end
