//
//  AnimatTextViewCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimatTextViewCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)ContentModel *model;
@end

NS_ASSUME_NONNULL_END
