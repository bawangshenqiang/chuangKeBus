//
//  HuaShanDetailBottomHeaderView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuaShanDetailBottomHeaderView : UIView
@property(nonatomic,strong)UIButton *praiseBtn;
@property(nonatomic,copy)void (^praiseBtnBlock)(void);
@property(nonatomic,strong)UILabel *praiseLab;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,copy)void (^collectBtnBlock)(void);
@property(nonatomic,strong)UILabel *collectLab;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,copy)void (^commentBtnBlock)(void);
@property(nonatomic,strong)UILabel *commentLab;
@property(nonatomic,strong)UIButton *sharedBtn;
@property(nonatomic,copy)void (^sharedBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
