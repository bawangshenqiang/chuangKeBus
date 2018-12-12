//
//  ResourceModel_ChuangYe_second.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceModel_ChuangYe_second.h"

@implementation ResourceModel_ChuangYe_second
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.logo=dic[@"logo"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        self.providerId=[dic[@"providerId"] intValue];
        self.status=[dic[@"status"] intValue];
        self.demand=dic[@"demand"];
        self.pstatus=dic[@"pstatus"];
        self.userId=[dic[@"userId"] intValue];
        self.create_time=dic[@"create_time"];
    }
    return self;
}
@end
