//
//  HotImageCell_HallFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hall_HomeTodayHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotImageCell_HallFirst : UITableViewCell
@property(nonatomic,strong)UIImageView *bigIV;
@property(nonatomic,strong)Hall_HomeTodayHotModel *model;
@property(nonatomic,copy)void (^ImageClickBlock)(Hall_HomeTodayHotModel *model);
@end

NS_ASSUME_NONNULL_END
