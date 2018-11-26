//
//  CustomPickerView.h
//  KR管理系统
//
//  Created by 霸枪001 on 2018/2/24.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIView *shadeView;
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,copy)void (^sureBtnBlock)(NSString *title,NSInteger index);
- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

@end
