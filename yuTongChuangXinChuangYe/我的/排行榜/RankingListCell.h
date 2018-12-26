//
//  RankingListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankingListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *leiJi;
@property(nonatomic,strong)UILabel *ticketLab;
@property(nonatomic,strong)UIImageView *medalIV;
@property(nonatomic,strong)UILabel *rangingLab;
@property(nonatomic,strong)RankingListModel *model;

@end

NS_ASSUME_NONNULL_END
