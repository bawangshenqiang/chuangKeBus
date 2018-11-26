//
//  HotTitleCell_HallFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hall_HomeTodayHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotTitleCell_HallFirst : UITableViewCell
@property(nonatomic,strong)NSMutableArray *headTitles;
@property(nonatomic,strong)NSMutableArray *titleLabs;
@property(nonatomic,strong)NSArray <Hall_HomeTodayHotModel *> *models;
@property(nonatomic,copy)void (^TitleClickBlock)(Hall_HomeTodayHotModel *model);
@end

NS_ASSUME_NONNULL_END
