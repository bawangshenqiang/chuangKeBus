//
//  ProjectCheckModel_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectCheckModel_ChuangYe.h"

@implementation ProjectCheckModel_ChuangYe
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.status=dic[@"status"];
        self.note=dic[@"note"];
        self.state=[dic[@"state"] intValue];
    }
    return self;
}
@end
