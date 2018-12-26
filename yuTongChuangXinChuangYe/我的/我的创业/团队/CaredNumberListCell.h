//
//  CaredNumberListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaredNumberListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CaredNumberListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *telephoneLab;
@property(nonatomic,strong)UIButton *teleBtn;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *position;
@property(nonatomic,strong)UILabel *userinfo;

@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)void (^lookAllBtnBlock)(NSIndexPath *indexPath);

@property(nonatomic,copy)void (^teleBtnBlock)(NSString *telephone);
@property(nonatomic,strong)CaredNumberListModel *model;

@end

NS_ASSUME_NONNULL_END
