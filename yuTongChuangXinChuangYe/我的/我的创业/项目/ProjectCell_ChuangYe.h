//
//  ProjectCell_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuangYiCellTopView.h"
#import "ProjectModel_ChuangYe.h"
//#import "CheckStatusView.h"
#import "CheckStatusView_scroll.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProjectCell_ChuangYe : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)ChuangYiCellTopView *topView;
@property(nonatomic,strong)CheckStatusView_scroll *statusView;
@property(nonatomic,strong)UILabel *checkIdeaLeft;
@property(nonatomic,strong)UILabel *checkIdea;
@property(nonatomic,strong)ProjectModel_ChuangYe *model;
@end

NS_ASSUME_NONNULL_END
