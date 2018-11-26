//
//  LoginCustomTF.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginCustomTF : UIView
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIButton *lookBtn;
@property(nonatomic,strong)UIButton *authCodeBtn;
@property(nonatomic,copy)void (^ lookAtPwdBlock)(BOOL flag);
@property(nonatomic,copy)void (^ authCodeBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
