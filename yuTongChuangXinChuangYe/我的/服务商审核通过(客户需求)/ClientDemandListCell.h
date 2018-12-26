//
//  ClientDemandListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientDemandListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClientDemandListCell : UITableViewCell
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *telephoneLab;
@property(nonatomic,strong)UIButton *teleBtn;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *demandLab;
@property(nonatomic,strong)UILabel *lookLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,copy)void (^teleBtnBlock)(NSString *telephone);
@property(nonatomic,strong)ClientDemandListModel *model;
@end

NS_ASSUME_NONNULL_END
