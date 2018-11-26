//
//  CatalogModel_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CatalogModel_video.h"

@implementation CatalogModel_video
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        //self.title=dic[@"title"];
        self.detail=dic[@"chapter"];
        self.create_time=dic[@"length"];
        self.urlString=dic[@"url"];
    }
    return self;
}
@end
