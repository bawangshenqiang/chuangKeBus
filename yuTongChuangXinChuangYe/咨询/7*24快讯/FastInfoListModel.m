//
//  FastInfoListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "FastInfoListModel.h"

@implementation FastInfoListModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.title=dic[@"title"];
        self.detailTitle=dic[@"descripetion"];
        self.times=dic[@"create_time"];
        self.fromStr=dic[@"source"];
        
    }
    return self;
}
@end
