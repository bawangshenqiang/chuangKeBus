//
//  ServeAuditingSecondCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinServerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServeAuditingSecondCell : UITableViewCell
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)JoinServerModel *model;
@end

NS_ASSUME_NONNULL_END
