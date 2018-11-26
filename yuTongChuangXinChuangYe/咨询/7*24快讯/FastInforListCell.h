//
//  FastInforListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastInforCellBottomView.h"
#import "FastInfoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FastInforListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)FastInforCellBottomView *bottomView;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)void (^flodClickBlock)(NSIndexPath *indexPath);
@property(nonatomic,copy)void (^shareClickBlock)(NSIndexPath *indexPath);
@property(nonatomic,strong)FastInfoListModel *model;
@end

NS_ASSUME_NONNULL_END
