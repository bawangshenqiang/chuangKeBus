//
//  DemandAlertView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemandAlertView : UIView
@property(nonatomic,strong)UIView *shadeView;
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,copy)void (^sureBtnBlock)(void);
//@property(nonatomic,strong)UIView *bigView_second;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)void (^sureBtnBlock_2)(NSString *refuse);
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@end

NS_ASSUME_NONNULL_END
