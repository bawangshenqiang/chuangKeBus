//
//  ServeHomeServiceCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCourseModel_Serve.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServeHomeServiceCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *serviceArr;
@property(nonatomic,copy)void (^selectAitemBlock)(NSInteger providerId);
@end

NS_ASSUME_NONNULL_END
