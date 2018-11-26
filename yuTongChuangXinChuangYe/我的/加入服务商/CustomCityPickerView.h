//
//  CustomCityPickerView.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/1.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCityPickerView : UIView
@property(nonatomic,strong)UIPickerView *cityPicker;
@property(nonatomic,copy)void (^SureClickBlock)(NSString *);
- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)data CompleteBlock:(void (^)(NSString *))completeBlock;
-(void)show;
@end

NS_ASSUME_NONNULL_END
