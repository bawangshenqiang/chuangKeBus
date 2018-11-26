//
//  CreativityDetailBottomCommentView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/31.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreativityDetailBottomCommentView : UIView<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,copy)void (^submitBtnBlock)(NSString *string);
@property(nonatomic,strong)UIButton *praiseBtn;
@property(nonatomic,copy)void (^praiseBtnBlock)(void);
@property(nonatomic,strong)UIButton *sharedBtn;
@property(nonatomic,copy)void (^sharedBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
