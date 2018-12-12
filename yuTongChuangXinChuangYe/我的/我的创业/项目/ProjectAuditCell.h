//
//  ProjectAuditCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuditSegmentView.h"
#import "AccessoryNameView.h"
#import "ProjectModel_ChuangYe.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectAuditCell : UITableViewCell
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *times;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *firstAuditStatus;
@property(nonatomic,strong)UILabel *secondAuditStatus;
@property(nonatomic,strong)UILabel *thirdAuditStatus;
@property(nonatomic,strong)UILabel *sugmentLab;
@property(nonatomic,strong)AuditSegmentView *segmentView;
@property(nonatomic,strong)UILabel *accessoryLoad;
@property(nonatomic,strong)AccessoryNameView *accessoryName;

@property(nonatomic,strong)ProjectModel_ChuangYe *model;
@end

NS_ASSUME_NONNULL_END
