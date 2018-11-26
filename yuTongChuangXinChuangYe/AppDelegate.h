//
//  AppDelegate.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) RDVTabBarController *tabBarController;

-(void)setupViewControllers;
- (void)displayLoginVC;

@end

