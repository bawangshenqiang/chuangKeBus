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
        self.findTeamUserId=[dic[@"teamId"] intValue];
        self.title=dic[@"title"];
        self.job=dic[@"job"];
        self.descriptions=dic[@"description"];
        self.create_time=dic[@"create_time"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
    }
    return self;
}
@end
