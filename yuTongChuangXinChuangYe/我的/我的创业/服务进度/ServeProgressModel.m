//
//  ServeProgressModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeProgressModel.h"

@implementation ServeProgressModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.providerId=[dic[@"providerId"] intValue];
        self.status=[dic[@"status"] intValue];
        self.userId=[dic[@"userId"] intValue];
        self.star=[dic[@"star"] intValue];
        self.nickname=dic[@"nickname"];
        self.photo=dic[@"photo"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
        self.title=dic[@"title"];
        self.demand=dic[@"demand"];
        self.refuse=dic[@"refuse"];
        self.comment=dic[@"comment"];
        self.create_time=dic[@"create_time"];
        self.reply_time=dic[@"reply_time"];
        self.comment_time=dic[@"comment_time"];
        self.done_time=dic[@"done_time"];
        self.name=dic[@"name"];
        self.telphone=dic[@"telphone"];
    }
    return self;
}
@end
