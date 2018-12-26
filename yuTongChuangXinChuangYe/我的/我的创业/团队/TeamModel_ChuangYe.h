//
//  TeamModel_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamModel_ChuangYe : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
/** 0-审核中 1-审核通过 2-审核失败 3-审核中 */
@property(nonatomic,assign)int state;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,assign)int talks;
@property(nonatomic,strong)NSString *note;
@property(nonatomic,strong)NSString *url;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
