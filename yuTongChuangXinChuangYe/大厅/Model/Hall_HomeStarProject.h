//
//  Hall_HomeStarProject.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 大厅首页 明星项目model
 */
@interface Hall_HomeStarProject : NSObject
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *category;//分类
@property(nonatomic,assign)int Id;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
