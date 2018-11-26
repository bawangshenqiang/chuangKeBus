//
//  UserMessageCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserMessageCell : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UserMessageModel *model;

@end

NS_ASSUME_NONNULL_END
