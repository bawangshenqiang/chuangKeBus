//
//  ChuangYiCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuangYiModel_ChuangYe.h"
#import "ChuangYiCellTopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChuangYiCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)ChuangYiCellTopView *topView;
@property(nonatomic,strong)UILabel *statusCircle;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *checkIdea;
@property(nonatomic,strong)ChuangYiModel_ChuangYe *model;

@end

NS_ASSUME_NONNULL_END
