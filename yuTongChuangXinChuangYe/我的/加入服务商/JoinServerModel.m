//
//  JoinServerModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/8.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "JoinServerModel.h"

@implementation JoinServerModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.typeId=[dic[@"typeId"] intValue];
        self.type=dic[@"type"];
        self.logo=dic[@"logo"];
        self.licence=dic[@"licence"];
        self.title=dic[@"title"];
        self.descriptions=dic[@"description"];
        self.details=dic[@"details"];
        self.services=dic[@"services"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
        self.email=dic[@"email"];
        self.address=dic[@"address"];
        
        self.status=[dic[@"status"] intValue];
        self.note=dic[@"note"];
    }
    return self;
}
@end
