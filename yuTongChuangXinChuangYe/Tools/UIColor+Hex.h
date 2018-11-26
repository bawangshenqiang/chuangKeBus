//
//  UIColor+Hex.h
//  BOSS_CHINA
//
//  Created by cx on 15/9/6.
//  Copyright (c) 2015年 DIGUO HOLDING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor*) colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHexString:(NSString *)hexValue;
@end
