//
//  TeamModel_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TeamModel_ChuangYe.h"

@implementation TeamModel_ChuangYe
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.title=dic[@"title"];
        self.state=[dic[@"state"] intValue];
        self.talks=[dic[@"talks"] intValue];
        self.create_time=dic[@"create_time"];
        self.status=dic[@"status"];
        self.note=dic[@"note"];
        self.url=dic[@"url"];
    }
    return self;
}
@end
