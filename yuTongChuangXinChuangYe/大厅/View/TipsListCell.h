//
//  TipsListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TipsListCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *separaterLine;
@property(nonatomic,strong)TipsListModel *model;
@end

NS_ASSUME_NONNULL_END
