//
//  SystemMessageModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemMessageModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int Id;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
