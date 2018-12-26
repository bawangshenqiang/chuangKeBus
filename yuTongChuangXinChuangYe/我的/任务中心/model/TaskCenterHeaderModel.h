//
//  TaskCenterHeaderModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCenterHeaderModel : NSObject
@property(nonatomic,assign)BOOL folding;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
