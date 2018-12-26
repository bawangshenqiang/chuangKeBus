//
//  CaredNumberListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CaredNumberListModel.h"

@implementation CaredNumberListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.descriptions=dic[@"description"];
        self.create_time=dic[@"create_time"];
        self.photo=dic[@"photo"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
        self.job=dic[@"job"];
    }
    return self;
}
@end
