//
//  SJPickerView.m
//  KR管理系统
//
//  Created by 霸枪001 on 2018/8/31.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "SJPickerView.h"

@implementation SJPickerView

- (instancetype)initWithFrame:(CGRect)frame modelArr:(NSMutableArray *)modelArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.modelArr=modelArr;
        //NSLog(@"%@",self.modelArr);
        
        self.shadeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.shadeView.backgroundColor=RGBAColor(0, 0, 0, 0.5);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteShadeView:)];
        [self.shadeView addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:self.shadeView];
        
        self.bigView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, frame.size.height)];
        self.bigView.backgroundColor=[UIColor whiteColor];
        [self.shadeView addSubview:self.bigView];
        
        self.cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.cancleBtn.frame=CGRectMake(0, 0, 60, 40);
        [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.cancleBtn];
        
        self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.frame=CGRectMake(kScreenWidth-60, 0, 60, 40);
        [self.sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bigView addSubview:self.sureBtn];
        
        self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.cancleBtn.bottom, kScreenWidth, frame.size.height-40)];
        self.pickerView.delegate=self;
        self.pickerView.dataSource=self;
        self.pickerView.showsSelectionIndicator=YES;
        [self.bigView addSubview:self.pickerView];
        
        [self show];
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.modelArr.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dic=self.modelArr[row];
    NSString *title=dic[@"name"];
    
    return title;
}

-(void)cancleClick{
    
    [self dismiss];
}
-(void)sureClick{
    
    NSInteger selectRow=[self.pickerView selectedRowInComponent:0];
    if (self.sureBtnBlock) {
        self.sureBtnBlock(self.modelArr[selectRow]);
    }
    [self dismiss];
}
-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        self.bigView.transform=CGAffineTransformMakeTranslation(0, -240);
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.bigView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [self.bigView removeFromSuperview];
        [self.shadeView removeFromSuperview];
        
    }];
}
-(void)deleteShadeView:(UITapGestureRecognizer *)tap{
    
    [self dismiss];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
