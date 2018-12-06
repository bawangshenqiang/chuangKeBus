//
//  CreativityEditModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreativityEditModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,assign)int categoryId;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *background;
@property(nonatomic,strong)NSString *services;
@property(nonatomic,strong)NSString *patterns;
@property(nonatomic,strong)NSString *linker;
@property(nonatomic,strong)NSString *linkphone;

-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
