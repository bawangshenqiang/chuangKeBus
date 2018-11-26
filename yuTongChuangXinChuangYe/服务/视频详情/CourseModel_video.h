//
//  CourseModel_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseModel_video : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *flag;
@property(nonatomic,assign)int peopleCount;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
