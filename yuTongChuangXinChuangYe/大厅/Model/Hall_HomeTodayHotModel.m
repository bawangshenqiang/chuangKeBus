//
//  Hall_HomeTodayHotModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Hall_HomeTodayHotModel.h"

@implementation Hall_HomeTodayHotModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.cover=dic[@"cover"];
        self.url=dic[@"url"];
        self.title=dic[@"title"];
        self.module=dic[@"module"];
        self.modulename=dic[@"modulename"];
        self.Id=[dic[@"id"] intValue];
        if ([dic.allKeys containsObject:@"description"]) {
            self.descriptions=dic[@"description"];
        }
    }
    return self;
}
@end
