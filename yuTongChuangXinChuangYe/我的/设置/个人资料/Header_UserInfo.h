//
//  Header_UserInfo.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Header_UserInfo : UIView
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,copy)void (^setImageBlock)(void);
@end

NS_ASSUME_NONNULL_END
