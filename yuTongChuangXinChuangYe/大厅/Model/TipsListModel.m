//
//  TipsListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TipsListModel.h"

@implementation TipsListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"Id"] intValue];
        self.title=dic[@"title"];
        self.url=dic[@"url"];
    }
    return self;
}
@end
