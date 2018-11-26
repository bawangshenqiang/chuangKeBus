//
//  CustomDatePickerView.m
//  KR管理系统
//
//  Created by 霸枪001 on 2018/3/7.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "CustomDatePickerView.h"

typedef void(^doneBlock)(NSDate *);

@interface CustomDatePickerView()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *buttomView;
@property(nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,copy)doneBlock doneBlock;
@property (nonatomic, retain) NSDate *currentDate; //默认显示时间

@end

@implementation CustomDatePickerView

- (instancetype)initWithFrame:(CGRect)frame CompleteBlock:(void (^)(NSDate *))completeBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentDate=[NSDate date];
        
        self.buttomView=[[UIView alloc]initWithFrame:CGRectMake(10, frame.size.height, frame.size.width-20, 260)];
        self.buttomView.backgroundColor=[UIColor whiteColor];
        self.buttomView.layer.cornerRadius = 10;
        self.buttomView.layer.masksToBounds = YES;
        [self addSubview:self.buttomView];
        
        //点击背景是否隐藏
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        [self layoutIfNeeded];
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
        
        [self.buttomView addSubview:self.datePicker];
        [self.buttomView addSubview:self.sureBtn];
        
        if (completeBlock) {
            self.doneBlock = ^(NSDate *theDate) {
                completeBlock(theDate);
            };
        }
    }
    return self;
}
-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.buttomView.width, self.buttomView.height-44)];
        //_datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, self.datePicker.bottom, self.buttomView.width, 44);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.backgroundColor=kThemeColor;
        _sureBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)dateChange:(UIDatePicker *)datePicker

{
    NSDate *theDate = datePicker.date;
    self.currentDate=theDate;
    
    self.doneBlock(theDate);
}
-(void)sureBtnClick{
    self.doneBlock(self.currentDate);
    if (self.SureClickBlock) {
        self.SureClickBlock(self.currentDate);
    }
    [self dismiss];
}
-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.buttomView.transform=CGAffineTransformMakeTranslation(0, -270);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.buttomView.transform=CGAffineTransformIdentity;
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.buttomView]) {
        return NO;
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
