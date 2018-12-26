//
//  BindingAccountViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindingAccountViewController : UIViewController
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,assign)BOOL fromSetPage;
@property(nonatomic,strong)NSString *name;//微信昵称
@end

NS_ASSUME_NONNULL_END
