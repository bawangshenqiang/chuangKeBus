//
//  HuaShanListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuaShanListModel : NSObject
@property(nonatomic,strong)NSString *headerUrl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *title;
//@property(nonatomic,strong)NSString *subtitle;
//@property(nonatomic,strong)NSString *bigImgUrl;
@property(nonatomic,assign)int comment;
@property(nonatomic,assign)int praise;
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)int postId;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
