//
//  ResourceModel_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/9.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceModel_ChuangYe : NSObject
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int providerId;
@property(nonatomic,strong)NSString *demand;//需求
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *status;//状态
@property(nonatomic,strong)NSString *note;//备注
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
