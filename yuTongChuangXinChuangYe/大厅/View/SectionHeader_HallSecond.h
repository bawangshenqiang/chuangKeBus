//
//  SectionHeader_HallSecond.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/4.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionHeader_HallSecond : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,copy)void (^moreBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
