//
//  Header_HuaShan.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/7.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Header_HuaShan : UIScrollView
@property(nonatomic,strong)NSMutableArray *titleArr;

@property(nonatomic,copy)void (^topSegmentChangeBlock)(int index);

@end

NS_ASSUME_NONNULL_END
