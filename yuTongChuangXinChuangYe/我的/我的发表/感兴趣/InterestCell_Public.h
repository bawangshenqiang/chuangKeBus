//
//  InterestCell_Public.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestModel_Public.h"

NS_ASSUME_NONNULL_BEGIN

@interface InterestCell_Public : UITableViewCell

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *position;
@property(nonatomic,strong)UILabel *userinfo;
@property(nonatomic,strong)UIView *separater;
@property(nonatomic,strong)InterestModel_Public *model;

@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)void (^lookAllBtnBlock)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
