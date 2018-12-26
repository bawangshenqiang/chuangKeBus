//
//  TicketRecordModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TicketRecordModel : NSObject
@property(nonatomic,strong)NSString *day;
@property(nonatomic,strong)NSArray *records;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
