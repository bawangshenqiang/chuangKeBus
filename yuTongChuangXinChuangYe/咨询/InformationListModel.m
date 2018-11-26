//
//  InformationListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InformationListModel.h"

@implementation InformationListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.cover=dic[@"cover"];
        self.label=dic[@"label"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        self.create_time=dic[@"create_time"];
        if ([dic.allKeys containsObject:@"source"]) {
            self.source=dic[@"source"];
        }
        if ([dic.allKeys containsObject:@"sources"]) {
            self.source=dic[@"sources"];
        }
        if ([dic.allKeys containsObject:@"policyId"]) {
            self.policyId=[dic[@"policyId"] intValue];
        }
        if ([dic.allKeys containsObject:@"informationId"]) {
            self.informationId=[dic[@"informationId"] intValue];
        }
    }
    return self;
}
@end
