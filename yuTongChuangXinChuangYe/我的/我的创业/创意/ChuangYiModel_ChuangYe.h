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
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *flagStr;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,strong)NSString *checkStatus;
@property(nonatomic,strong)NSString *checkIdea;
@property(nonatomic,assign)int Id;
/** 0,3 审核中 1-已通过 2-未通过 */
@property(nonatomic,assign)int statusId;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *url;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
