//
//  ClientDemandListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ClientDemandListModel.h"

@implementation ClientDemandListModel
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
        self.pstatus=dic[@"pstatus"];
        self.demand=dic[@"demand"];
        self.refuse=dic[@"refuse"];
        self.comment=dic[@"comment"];
        self.create_time=dic[@"create_time"];
    }
    return self;
}
@end
