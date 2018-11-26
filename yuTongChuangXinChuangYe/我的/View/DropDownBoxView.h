//
//  DropDownBoxView.h
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/28.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SJDropDownBoxViewBlock)(NSString *text);

@interface DropDownBoxView : UIView

@property (nonatomic, copy) SJDropDownBoxViewBlock choseDropDownBoxBlock;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray*)titleArr;

- (void)choseDropDownBoxBlock:(SJDropDownBoxViewBlock)block;

-(void)dismiss;

@end
