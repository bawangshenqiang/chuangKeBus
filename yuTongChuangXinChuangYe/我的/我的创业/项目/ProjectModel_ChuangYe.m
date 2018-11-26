//
//  ProjectModel_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectModel_ChuangYe.h"

@implementation ProjectModel_ChuangYe
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        
        self.imageUrl=dic[@"cover"];
        self.title=dic[@"title"];
        self.flagStr=dic[@"category"];
        self.times=dic[@"create_time"];
        self.projectId=[dic[@"projectId"] intValue];
        self.checkModels=[NSMutableArray array];
        if ([dic.allKeys containsObject:@"approves"]) {
            for (NSDictionary *dict in dic[@"approves"]) {
                ProjectCheckModel_ChuangYe *model=[[ProjectCheckModel_ChuangYe alloc]initWithDictionary:dict];
                [self.checkModels addObject:model];
            }
        }
    }
    return self;
}
@end
