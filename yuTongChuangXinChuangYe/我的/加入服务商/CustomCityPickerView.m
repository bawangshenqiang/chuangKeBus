//
//  CustomCityPickerView.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/1.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CustomCityPickerView.h"
typedef void(^doneBlock)(NSString *);

@interface CustomCityPickerView()<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *buttomView;
@property(nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,copy)doneBlock doneBlock;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *provinces;
@property(nonatomic,strong)NSMutableArray *citys;
@property(nonatomic,strong)NSString *selectProvince;
@property(nonatomic,strong)NSString *selectCity;

@end

@implementation CustomCityPickerView

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)data CompleteBlock:(void (^)(NSString *))completeBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr=data;
        self.provinces=[NSMutableArray array];
        self.citys=[NSMutableArray array];
        for (int i=0; i<self.dataArr.count; i++) {
            NSDictionary *dic=self.dataArr[i];
            [self.provinces addObject:dic[@"province"]];
            if (i==0) {
                NSDictionary *dict=self.dataArr[0];
                self.citys=dict[@"city"];
            }
        }
        
        self.selectProvince = self.provinces[0];
        self.selectCity = self.citys[0];
        
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
        
        [self.buttomView addSubview:self.cityPicker];
        [self.buttomView addSubview:self.sureBtn];
        
        if (completeBlock) {
            self.doneBlock = ^(NSString *string) {
                completeBlock(string);
            };
        }
    }
    return self;
}
-(UIPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.buttomView.width, self.buttomView.height-44)];
        _cityPicker.backgroundColor=[UIColor whiteColor];
        _cityPicker.delegate=self;
        _cityPicker.dataSource=self;
    }
    return _cityPicker;
}
-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, self.cityPicker.bottom, self.buttomView.width, 44);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.backgroundColor=kThemeColor;
        _sureBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

//有几个表盘（component）
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//没个表盘有几行数据（rows）
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    NSInteger rows = 0;
    switch (component) {
        case 0:
            rows = self.provinces.count;
            break;
        case 1:
            rows = self.citys.count;
            break;
        default:
            break;
    }
    return rows;
}

//每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.provinces[row];
            break;
        case 1:
            title = self.citys[row];
            break;
        default:
            break;
    }
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        self.citys=[self getCityNamesFromProvinceIndex:row];
        [self.cityPicker reloadComponent:1];
        [self.cityPicker selectRow:0 inComponent:1 animated:YES];
        self.selectProvince = self.provinces[row];
        self.selectCity = self.citys[0];
    }else{
        self.selectCity = self.citys[row];
    }
}
- (NSMutableArray *)getCityNamesFromProvinceIndex:(NSInteger)provinceIndex{
    NSDictionary * tempDic = self.dataArr[provinceIndex];
    NSMutableArray * cityArray = [NSMutableArray array];
    cityArray=tempDic[@"city"];
    return cityArray;
}
-(void)sureBtnClick{
    if (self.SureClickBlock) {
        self.SureClickBlock([NSString stringWithFormat:@"%@-%@",self.selectProvince,self.selectCity]);
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
