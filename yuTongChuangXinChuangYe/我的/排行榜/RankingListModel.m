//
//  RankingListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "RankingListModel.h"

@implementation RankingListModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.nickname=dic[@"nickname"];
        self.photo=dic[@"photo"];
        self.score=[dic[@"score"] intValue];
    }
    return self;
}
@end
