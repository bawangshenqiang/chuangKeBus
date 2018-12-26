//
//  ServeProgressViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServeProgressViewController : UIViewController
@property(nonatomic,assign)int userId;
@property(nonatomic,assign)int demandId;
@property(nonatomic,assign)int providerId;
@property(nonatomic,assign)BOOL isUser;//是用户的身份，还是服务商的身份
@end

NS_ASSUME_NONNULL_END
