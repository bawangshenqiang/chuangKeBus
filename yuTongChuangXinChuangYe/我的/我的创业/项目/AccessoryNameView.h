//
//  AccessoryNameView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectCheckModel_ChuangYe.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccessoryNameView : UIView
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,copy)void (^btnClickBlock)(NSString *string);
@end

NS_ASSUME_NONNULL_END
