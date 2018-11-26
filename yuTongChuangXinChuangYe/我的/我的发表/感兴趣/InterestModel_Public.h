//
//  InterestModel_Public.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InterestModel_Public : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int findTeamUserId;//伙伴ID
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *create_time;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
