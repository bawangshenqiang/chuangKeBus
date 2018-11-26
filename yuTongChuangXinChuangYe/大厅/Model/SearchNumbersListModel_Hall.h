//
//  SearchNumbersListModel_Hall.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchNumbersListModel_Hall : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *category;//分类
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *note;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
