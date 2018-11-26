//
//  CheckStatusView_scroll.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectCheckModel_ChuangYe.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckStatusView_scroll : UIScrollView
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)NSMutableArray <ProjectCheckModel_ChuangYe *> *checkModels;
@end

NS_ASSUME_NONNULL_END
