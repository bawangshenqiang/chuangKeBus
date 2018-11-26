//
//  CreativityEditModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CreativityEditModel.h"

@implementation CreativityEditModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.categoryId=[dic[@"categoryId"] intValue];
        self.title=dic[@"title"];
        self.descriptions=dic[@"description"];
        self.cover=dic[@"cover"];
        self.category=dic[@"category"];
        self.background=dic[@"background"];
        self.services=dic[@"services"];
        self.patterns=dic[@"patterns"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
    }
    return self;
}
@end
