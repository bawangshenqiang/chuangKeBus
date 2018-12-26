//
//  TaskCenterHeaderModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TaskCenterHeaderModel.h"

@implementation TaskCenterHeaderModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.title=dic[@"title"];
        self.subTitle=dic[@"subTitle"];
    }
    return self;
}
@end
