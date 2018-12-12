//
//  ChuangYiCell_ChuangYe_Second.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/7.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuangYiModel_ChuangYe.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChuangYiCell_ChuangYe_Second : UITableViewCell
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIImageView *topIV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UIButton *checkIdeaBut;
@property(nonatomic,strong)ChuangYiModel_ChuangYe *model;
@property(nonatomic,copy)void (^checkIdeaBlock)(ChuangYiModel_ChuangYe *model);
@end

NS_ASSUME_NONNULL_END
