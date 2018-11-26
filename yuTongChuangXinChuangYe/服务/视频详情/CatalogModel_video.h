//
//  CatalogModel_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CatalogModel_video : NSObject
@property(nonatomic,assign)int Id;
//@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *urlString;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
