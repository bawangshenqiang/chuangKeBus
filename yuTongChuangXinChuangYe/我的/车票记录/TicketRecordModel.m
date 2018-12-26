//
//  TicketRecordModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "TicketRecordModel.h"

@implementation TicketRecordModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.day=dic[@"day"];
        self.records=dic[@"records"];
    }
    return self;
}
@end
