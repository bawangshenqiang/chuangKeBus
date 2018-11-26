//
//  TeamEditModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TeamEditModel.h"

@implementation TeamEditModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.categoryId=[dic[@"categoryId"] intValue];
        self.title=dic[@"title"];
        self.name=dic[@"name"];
        self.job=dic[@"job"];
        self.category=dic[@"category"];
        self.province=dic[@"province"];
        self.city=dic[@"city"];
        self.project=dic[@"project"];
        self.team=dic[@"team"];
        self.demand=dic[@"demand"];
    }
    return self;
}
@end
