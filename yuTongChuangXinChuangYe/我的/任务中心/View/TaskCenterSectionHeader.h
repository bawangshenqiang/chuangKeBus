//
//  TaskCenterSectionHeader.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCenterHeaderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskCenterSectionHeader : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UIImageView *foldIV;
@property(nonatomic,assign)NSInteger taag;
@property(nonatomic,strong)TaskCenterHeaderModel *model;
@property(nonatomic,copy)void (^foldClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
