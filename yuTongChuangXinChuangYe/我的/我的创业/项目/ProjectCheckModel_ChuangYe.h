//
//  ProjectCheckModel_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 多次审核的model
 */
@interface ProjectCheckModel_ChuangYe : NSObject
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *note;
@property(nonatomic,assign)int state;//0等待,1通过,2拒绝
@property(nonatomic,strong)NSString *suggestion;
@property(nonatomic,strong)NSString *suggestionfile;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
