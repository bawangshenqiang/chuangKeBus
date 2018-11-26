//
//  PolicyTopView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PolicyTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArr;

-(void)setImage:(NSArray *)imageArr andSelectedImage:(NSArray *)selectedImage;

@property(nonatomic,copy)void (^buttonClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
