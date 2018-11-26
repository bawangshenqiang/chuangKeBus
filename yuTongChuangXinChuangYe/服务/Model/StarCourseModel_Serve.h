//
//  StarCourseModel_Serve.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StarCourseModel_Serve : NSObject
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *descripetions;
@property(nonatomic,assign)int views;//浏览数
@property(nonatomic,assign)int courseId;
@property(nonatomic,assign)int providerId;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
