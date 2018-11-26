//
//  Hall_HomeTodayHotModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 大厅首页 今日最热 固定4条数据，第一条带图片
 */
@interface Hall_HomeTodayHotModel : NSObject
@property(nonatomic,strong)NSString *cover;//就第一个有图
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *module;//分类
@property(nonatomic,strong)NSString *modulename;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *descriptions;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
