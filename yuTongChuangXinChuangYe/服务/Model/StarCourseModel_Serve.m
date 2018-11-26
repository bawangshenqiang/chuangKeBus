//
//  StarCourseModel_Serve.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "StarCourseModel_Serve.h"

@implementation StarCourseModel_Serve
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        if ([dic.allKeys containsObject:@"cover"]) {
            self.picture=dic[@"cover"];
        }else if ([dic.allKeys containsObject:@"logo"]) {
            self.picture=dic[@"logo"];
        }
        
        self.title=dic[@"title"];
        self.Id=[dic[@"id"] intValue];
        if ([dic.allKeys containsObject:@"descripetion"]) {
            self.descripetions=dic[@"descripetion"];
        }
        if ([dic.allKeys containsObject:@"description"]) {
            self.descripetions=dic[@"description"];
        }
        if ([dic.allKeys containsObject:@"label"]) {
            self.label=dic[@"label"];
        }
        self.views=[dic[@"views"] intValue];
        if ([dic.allKeys containsObject:@"courseId"]) {
            self.courseId=[dic[@"courseId"] intValue];
        }
        if ([dic.allKeys containsObject:@"providerId"]) {
            self.providerId=[dic[@"providerId"] intValue];
        }
    }
    return self;
}
@end
