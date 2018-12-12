//
//  ResourceCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceModel_ChuangYe_second.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResourceCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UIButton *nameBtn;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *needExplain;//需求说明
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *progressLab;
@property(nonatomic,copy)void (^btnClickBlock)(int iD);
@property(nonatomic,strong)ResourceModel_ChuangYe_second *model;
@end

NS_ASSUME_NONNULL_END
