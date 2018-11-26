//
//  HuaShanCell_First.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuaShanListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HuaShanCell_First : UITableViewCell
@property(nonatomic,strong)UIImageView *headerIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subtitleLab;
@property(nonatomic,strong)UIImageView *bigIV;
@property(nonatomic,strong)UIImageView *commentIV;
@property(nonatomic,strong)UILabel *commentLab;
@property(nonatomic,strong)UIImageView *praiseIV;
@property(nonatomic,strong)UILabel *praiseLab;

@property(nonatomic,strong)UIView *separaterView;
@property(nonatomic,strong)HuaShanListModel *model;
@end

NS_ASSUME_NONNULL_END
