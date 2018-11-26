//
//  InterestCell_Public.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestModel_Public.h"

NS_ASSUME_NONNULL_BEGIN

@interface InterestCell_Public : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)InterestModel_Public *model;

@end

NS_ASSUME_NONNULL_END
