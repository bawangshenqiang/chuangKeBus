//
//  TeamCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchNumbersListModel_Hall.h"
NS_ASSUME_NONNULL_BEGIN

@interface TeamCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UIImageView *flag1IV;
@property(nonatomic,strong)UILabel *flag1Lab;
@property(nonatomic,strong)UIImageView *flag2IV;
@property(nonatomic,strong)UILabel *flag2Lab;
@property(nonatomic,strong)UIImageView *flag3IV;
@property(nonatomic,strong)UILabel *flag3Lab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIView *separatorLine;
@property(nonatomic,strong)UILabel *statusCircle;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *checkIdea;
@property(nonatomic,strong)SearchNumbersListModel_Hall *model;
@end

NS_ASSUME_NONNULL_END
