//
//  UploadPlanFileViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadPlanFileViewController : UIViewController
@property(nonatomic,copy)void (^CallBack)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
