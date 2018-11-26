//
//  TopView_MyInfo.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopView_MyInfo : UIView
@property(nonatomic,strong)UIImageView *headerIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIButton *setBtn;
@property(nonatomic,strong)UILabel *mesCountLab;
@property(nonatomic,copy)void (^HeaderClickBlock)(void);
@property(nonatomic,copy)void (^loginClickBlock)(void);
@property(nonatomic,copy)void (^setClickedBlock)(void);
@property(nonatomic,copy)void (^fourBtnClickBlock)(NSInteger index);
@property(nonatomic,copy)void (^threeBtnClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
