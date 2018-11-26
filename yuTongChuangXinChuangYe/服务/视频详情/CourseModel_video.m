//
//  CourseModel_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CourseModel_video.h"

@implementation CourseModel_video
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.imageUrl=dic[@"imageUrl"];
        self.title=dic[@"title"];
        self.flag=dic[@"flag"];
        self.peopleCount=[dic[@"peopleCount"] intValue];
    }
    return self;
}
@end
