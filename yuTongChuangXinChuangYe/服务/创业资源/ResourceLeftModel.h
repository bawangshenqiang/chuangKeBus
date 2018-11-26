//
//  ResourceLeftModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceRightModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResourceLeftModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)NSMutableArray <ResourceRightModel *> *rightModels;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
