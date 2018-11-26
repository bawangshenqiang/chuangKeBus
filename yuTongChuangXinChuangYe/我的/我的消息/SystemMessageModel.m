//
//  SystemMessageModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.title=dic[@"title"];
        self.detail=dic[@"description"];
        self.create_time=dic[@"create_time"];
        self.url=dic[@"url"];
        self.Id=[dic[@"id"] intValue];
    }
    return self;
}
@end
