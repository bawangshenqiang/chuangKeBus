//
//  ChuangYiModel_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChuangYiModel_ChuangYe : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *flagStr;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,strong)NSString *checkStatus;
@property(nonatomic,strong)NSString *checkIdea;
@property(nonatomic,assign)int Id;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
