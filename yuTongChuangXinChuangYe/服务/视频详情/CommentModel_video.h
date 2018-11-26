//
//  CommentModel_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel_video : NSObject
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *detail;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
