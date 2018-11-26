//
//  TableHeader_HallFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/15.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableHeader_HallFirst : UIView
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSArray *cycleImageUrls;
@property(nonatomic,copy)void (^threeBtnClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
