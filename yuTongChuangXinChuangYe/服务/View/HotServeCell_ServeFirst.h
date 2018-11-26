//
//  HotServeCell_ServeFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCourseModel_Serve.h"
NS_ASSUME_NONNULL_BEGIN

@interface HotServeCell_ServeFirst : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,copy)void (^ACellBtnClickBlock)(NSInteger index);
@property(nonatomic,strong)NSMutableArray <StarCourseModel_Serve *> *models;
@end

NS_ASSUME_NONNULL_END
