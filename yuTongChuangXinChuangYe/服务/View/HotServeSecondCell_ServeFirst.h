//
//  HotServeSecondCell_ServeFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCourseModel_Serve.h"
#import "Hall_HomeTodayHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotServeSecondCell_ServeFirst : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)StarCourseModel_Serve *model;
@property(nonatomic,strong)Hall_HomeTodayHotModel *hallModel;
@end

NS_ASSUME_NONNULL_END
