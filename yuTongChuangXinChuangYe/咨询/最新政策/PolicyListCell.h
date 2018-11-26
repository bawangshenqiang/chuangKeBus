//
//  PolicyListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PolicyListCell : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UIButton *flagBtn;
@property(nonatomic,strong)UILabel *fromLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)InformationListModel *model;

@end

NS_ASSUME_NONNULL_END
