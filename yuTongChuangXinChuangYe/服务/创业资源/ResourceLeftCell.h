//
//  ResourceLeftCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceLeftModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResourceLeftCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)ResourceLeftModel *leftModel;

@end

NS_ASSUME_NONNULL_END
