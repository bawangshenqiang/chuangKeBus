//
//  ServeEvaluateContentCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServeProgressModel.h"
#import "RatingBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServeEvaluateContentCell : UITableViewCell
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)RatingBar *ratingBar;
@property(nonatomic,strong)ServeProgressModel *model;
@end

NS_ASSUME_NONNULL_END
