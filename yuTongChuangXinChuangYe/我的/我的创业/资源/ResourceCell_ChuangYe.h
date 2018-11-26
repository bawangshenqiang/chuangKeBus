//
//  ResourceCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceModel_ChuangYe.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResourceCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *bottomLab;
@property(nonatomic,strong)UIView *separatorLine;
@property(nonatomic,strong)UILabel *needExplain;//需求说明
@property(nonatomic,strong)ResourceModel_ChuangYe *model;
@end

NS_ASSUME_NONNULL_END
