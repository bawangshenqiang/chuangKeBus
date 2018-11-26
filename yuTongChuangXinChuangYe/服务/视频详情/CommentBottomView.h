//
//  CommentBottomView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentBottomView : UIView
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,copy)void (^submitBtnBlock)(NSString *string);
@end

NS_ASSUME_NONNULL_END
