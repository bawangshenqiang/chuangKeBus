//
//  CommentModel_video.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentModel_video.h"

@implementation CommentModel_video
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.photo=dic[@"photo"];
        self.nickname=dic[@"nickname"];
        self.create_time=dic[@"create_time"];
        self.detail=dic[@"comment"];
    }
    return self;
}
@end
