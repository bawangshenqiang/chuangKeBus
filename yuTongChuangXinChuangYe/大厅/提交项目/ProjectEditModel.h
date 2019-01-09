//
//  ProjectEditModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/6.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjectEditModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,assign)int categoryId;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *appeal;//项目诉求
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *linker;
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,assign)int status;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *planfile;
@property(nonatomic,strong)NSString *planname;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
