//
//  HuaShanListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "HuaShanListModel.h"

@implementation HuaShanListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.headerUrl=dic[@"photo"];
        self.name=dic[@"nickname"];
        self.time=dic[@"create_time"];
        self.title=dic[@"title"];
        self.comment=[dic[@"comments"] intValue];
        self.praise=[dic[@"praises"] intValue];
        self.Id=[dic[@"id"] intValue];
        if ([dic.allKeys containsObject:@"postId"]) {
            self.postId=[dic[@"postId"] intValue];
        }
    }
    return self;
}
@end
