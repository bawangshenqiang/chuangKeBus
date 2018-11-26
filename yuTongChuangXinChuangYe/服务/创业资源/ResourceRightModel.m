//
//  ResourceRightModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceRightModel.h"

@implementation ResourceRightModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.logo=dic[@"logo"];
        self.Id=[dic[@"id"] intValue];
        self.title=dic[@"title"];
        self.descriptions=dic[@"description"];
    }
    return self;
}
@end
