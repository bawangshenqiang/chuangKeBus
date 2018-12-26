//
//  TeamCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TeamModel_ChuangYe.h"
NS_ASSUME_NONNULL_BEGIN

@interface TeamCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIButton *title;
@property(nonatomic,strong)UIImageView *flagIV;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *status;
@property(nonatomic,strong)UILabel *checkIdeaLab;
@property(nonatomic,strong)UILabel *checkIdea;
@property(nonatomic,strong)UILabel *careLab;
@property(nonatomic,strong)UILabel *lookLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)TeamModel_ChuangYe *model;
@property(nonatomic,copy)void (^titleClickBlock)(TeamModel_ChuangYe *model);
@end

NS_ASSUME_NONNULL_END
