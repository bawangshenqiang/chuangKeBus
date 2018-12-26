//
//  TaskCenterHeaderView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TastTop.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskCenterHeaderView : UIView
@property(nonatomic,strong)TastTop *topView;
@property(nonatomic,strong)UILabel *todayTicket;
@property(nonatomic,copy)void (^recordClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
