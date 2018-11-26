//
//  Hot_24.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hot_24 : UIView
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *monthLab;
@property(nonatomic,strong)UILabel *dayLab;
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)NSMutableArray *titleLabs;
@property(nonatomic,copy)void (^Hot_24ClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
