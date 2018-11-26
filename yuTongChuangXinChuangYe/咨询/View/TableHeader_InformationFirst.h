//
//  TableHeader_InformationFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hot_24.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableHeader_InformationFirst : UIView
@property(nonatomic,strong)UIImageView *topIV;
@property(nonatomic,strong)NSDictionary *topImage;
@property(nonatomic,strong)Hot_24 *hot_24;
@property(nonatomic,copy)void (^fourBtnClickBlock)(NSInteger index);
@property(nonatomic,copy)void (^topImageClickBlock)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
