//
//  JoinServerModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/8.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoinServerModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int typeId;//服务类型
@property(nonatomic,strong)NSString *type;//服务类型
@property(nonatomic,strong)NSString *logo;//服务商图片
@property(nonatomic,strong)NSString *licence;//营业执照
@property(nonatomic,strong)NSString *title;//服务商名称
@property(nonatomic,strong)NSString *descriptions;//简介
@property(nonatomic,strong)NSString *details;//公司详情
@property(nonatomic,strong)NSString *services;//服务详情
@property(nonatomic,strong)NSString *linker;
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *address;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
