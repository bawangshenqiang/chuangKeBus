//
//  ResourceRightModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceRightModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *descriptions;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
