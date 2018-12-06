//
//  ProjectEditModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectEditModel.h"

@implementation ProjectEditModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.categoryId=[dic[@"categoryId"] intValue];
        self.title=dic[@"title"];
        self.descriptions=dic[@"description"];
        self.cover=dic[@"cover"];
        self.category=dic[@"category"];
        self.appeal=dic[@"appeal"];
        self.content=dic[@"content"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
        
        self.status=[dic[@"status"] intValue];
        self.username=dic[@"username"];
    }
    return self;
}
@end
