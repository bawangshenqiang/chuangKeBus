//
//  SearchNumbersListModel_Hall.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchNumbersListModel_Hall.h"

@implementation SearchNumbersListModel_Hall
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.name=dic[@"name"];
        self.category=dic[@"category"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        self.create_time=dic[@"create_time"];
        self.job=dic[@"job"];
        self.status=dic[@"status"];
        self.note=dic[@"note"];
        self.url=dic[@"url"];
    }
    return self;
}
@end
