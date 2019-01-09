//
//  SearchCreativityListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "SearchCreativityListModel.h"

@implementation SearchCreativityListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.cover=dic[@"cover"];
        self.category=dic[@"category"];
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        self.create_time=dic[@"create_time"];
        self.descriptions=dic[@"description"];
        self.url=dic[@"url"];
    }
    return self;
}
@end
