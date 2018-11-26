//
//  ChuangYiModel_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ChuangYiModel_ChuangYe.h"

@implementation ChuangYiModel_ChuangYe
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.imageUrl=dic[@"cover"];
        self.title=dic[@"title"];
        self.flagStr=dic[@"category"];
        self.times=dic[@"create_time"];
        self.checkStatus=dic[@"status"];
        self.checkIdea=dic[@"note"];
        self.Id=[dic[@"id"] intValue];
    }
    return self;
}
@end
