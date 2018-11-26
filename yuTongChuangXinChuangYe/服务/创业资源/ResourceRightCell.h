//
//  ResourceRightCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceRightModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResourceRightCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)ResourceRightModel *model;

@end

NS_ASSUME_NONNULL_END
