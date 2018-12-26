//
//  ClientDemandListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientDemandListModel : NSObject
@property(nonatomic,assign)int Id;//需求ID
@property(nonatomic,assign)int providerId;//服务商ID
@property(nonatomic,assign)int userId;//提交需求用户ID
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *linker;//联系人
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,assign)int status;
@property(nonatomic,assign)int star;//评星
@property(nonatomic,strong)NSString *demand;//需求详情
@property(nonatomic,strong)NSString *refuse;//拒绝理由
@property(nonatomic,strong)NSString *comment;//评论内容
@property(nonatomic,strong)NSString *pstatus;//显示状态
@property(nonatomic,strong)NSString *create_time;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
