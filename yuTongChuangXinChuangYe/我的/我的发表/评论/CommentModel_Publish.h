//
//  CommentModel_Publish.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel_Publish : NSObject
@property(nonatomic,assign)int targetId;//帖子ID
@property(nonatomic,strong)NSString *module;//类别
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *cover;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
