//
//  ThreeAuditView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/11.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreeAuditView : UIView
@property(nonatomic,strong)UILabel *firstCircle;
@property(nonatomic,strong)UILabel *secondCircle;
@property(nonatomic,strong)UILabel *thirdCircle;
@property(nonatomic,strong)UIView *firstLine;
@property(nonatomic,strong)UIView *secondLine;

@property(nonatomic,strong)UILabel *firstTitle;
@property(nonatomic,strong)UILabel *secondTitle;
@property(nonatomic,strong)UILabel *thirdTitle;

-(void)resetCircleFrameAndLineColor:(int)index;

@end

NS_ASSUME_NONNULL_END
