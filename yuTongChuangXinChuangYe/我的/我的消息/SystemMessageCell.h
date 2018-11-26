//
//  SystemMessageCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SystemMessageCell : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)SystemMessageModel *model;

@end

NS_ASSUME_NONNULL_END
