//
//  CommentModel_Publish.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentModel_Publish.h"

@implementation CommentModel_Publish
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.targetId=[dic[@"targetId"] intValue];
        self.title=dic[@"title"];
        self.comment=dic[@"comment"];
        self.create_time=dic[@"create_time"];
        self.module=dic[@"module"];
        self.cover=dic[@"cover"];
    }
    return self;
}
@end
