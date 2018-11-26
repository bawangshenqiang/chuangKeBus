//
//  Hall_HomeStarProject.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "Hall_HomeStarProject.h"

@implementation Hall_HomeStarProject
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.cover=dic[@"cover"];
        self.category=dic[@"category"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
    }
    return self;
}
@end
