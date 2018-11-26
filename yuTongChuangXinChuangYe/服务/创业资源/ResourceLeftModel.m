//
//  ResourceLeftModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ResourceLeftModel.h"

@implementation ResourceLeftModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.title=dic[@"name"];
        self.rightModels=[NSMutableArray array];
        if ([dic.allKeys containsObject:@"providers"]) {
            for (NSDictionary *dict in dic[@"providers"]) {
                ResourceRightModel *model=[[ResourceRightModel alloc]initWithDictionary:dict];
                [self.rightModels addObject:model];
            }
        }
    }
    return self;
}
@end
