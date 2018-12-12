//
//  ResourceModel_ChuangYe_second.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceModel_ChuangYe_second : NSObject
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int providerId;
@property(nonatomic,strong)NSString *demand;//需求
//@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *pstatus;//状态
@property(nonatomic,assign)int status;//状态
//@property(nonatomic,strong)NSString *note;//备注
@property(nonatomic,assign)int userId;
@property(nonatomic,strong)NSString *create_time;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
