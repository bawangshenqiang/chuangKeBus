//
//  CustomDatePickerView.h
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/7.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePickerView : UIView
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,copy)void (^SureClickBlock)(NSDate *);

- (instancetype)initWithFrame:(CGRect)frame CompleteBlock:(void (^)(NSDate *))completeBlock;
-(void)show;
@end
