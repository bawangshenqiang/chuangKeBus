//
//  SubmitServeNeedViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubmitServeNeedViewController : UIViewController
@property(nonatomic,assign)NSInteger providerId;
@property(nonatomic,strong)NSString *serverName;//服务商名称
@property(nonatomic,strong)NSString *categoryName;//分类
@end

NS_ASSUME_NONNULL_END
