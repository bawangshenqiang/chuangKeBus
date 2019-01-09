//
//  CaredNumberListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaredNumberListModel : NSObject
@property(nonatomic,assign)int Id;//需求ID
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *linker;
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,assign)BOOL showAll;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
