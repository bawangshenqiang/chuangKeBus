//
//  AnimatTextFieldCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimatTextFieldCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UITextField *textField;

@end

NS_ASSUME_NONNULL_END
