//
//  BottomView_Publish.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/30.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomView_Publish : UIView
@property(nonatomic,strong)UIButton *fontBtn;
@property(nonatomic,strong)UIButton *imageBtn;
@property(nonatomic,copy)void (^fontBtnBlock)(void);
@property(nonatomic,copy)void (^imageBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
