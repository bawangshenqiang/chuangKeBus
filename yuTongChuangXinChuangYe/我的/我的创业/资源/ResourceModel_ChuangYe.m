//
//  ResourceModel_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/9.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceModel_ChuangYe.h"

@implementation ResourceModel_ChuangYe
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.logo=dic[@"logo"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        self.providerId=[dic[@"providerId"] intValue];
        self.descriptions=dic[@"description"];
        self.demand=dic[@"demand"];
        self.status=dic[@"status"];
        self.note=dic[@"note"];
        
    }
    return self;
}
@end
