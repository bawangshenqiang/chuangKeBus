//
//  InformationListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InformationListModel : NSObject
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *label;//分类
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,assign)int policyId;
@property(nonatomic,assign)int informationId;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
