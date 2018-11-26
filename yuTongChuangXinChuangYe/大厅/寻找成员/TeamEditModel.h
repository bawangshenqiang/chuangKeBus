//
//  TeamEditModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamEditModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)int categoryId;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *project;
@property(nonatomic,strong)NSString *team;
@property(nonatomic,strong)NSString *demand;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
