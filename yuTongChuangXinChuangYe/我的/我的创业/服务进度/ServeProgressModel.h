//
//  ServeProgressModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServeProgressModel : NSObject
@property(nonatomic,assign)int Id;//需求ID
@property(nonatomic,assign)int providerId;//服务商ID
/** 0-待回复 1-服务中 2-服务完成 3-评价完成 4-服务关闭(已拒绝) */
@property(nonatomic,assign)int status;
@property(nonatomic,assign)int userId;//提交需求用户ID
@property(nonatomic,assign)int star;//评星
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *linker;//联系人
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,strong)NSString *title;//服务商标题
@property(nonatomic,strong)NSString *demand;//需求详情
@property(nonatomic,strong)NSString *refuse;//拒绝理由
@property(nonatomic,strong)NSString *comment;//评论内容
@property(nonatomic,strong)NSString *create_time;//需求提交时间
@property(nonatomic,strong)NSString *reply_time;//需求回复时间
@property(nonatomic,strong)NSString *comment_time;//需求评论时间
@property(nonatomic,strong)NSString *done_time;//需求完成时间
@property(nonatomic,strong)NSString *name;//真实姓名
@property(nonatomic,strong)NSString *telphone;//
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
