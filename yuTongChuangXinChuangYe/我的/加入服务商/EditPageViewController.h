//
//  EditPageViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditPageViewController : UIViewController
@property(nonatomic,strong)NSString *oldString;
@property(nonatomic,copy)void (^callBackBlock)(NSString *string);
@property(nonatomic,assign)BOOL isIntro;
@property(nonatomic,assign)BOOL countControl;
@end

NS_ASSUME_NONNULL_END
