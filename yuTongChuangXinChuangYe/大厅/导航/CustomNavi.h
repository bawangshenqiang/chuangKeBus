//
//  CustomNavi.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomNavi : UIView
@property(nonatomic,strong)UIButton *messageBtn;
@property(nonatomic,strong)UIView *redDot;
@property(nonatomic,copy)void (^ TouchSearchBlock)(void);
@property(nonatomic,copy)void (^ TouchMessageBlock)(void);
@end

NS_ASSUME_NONNULL_END
