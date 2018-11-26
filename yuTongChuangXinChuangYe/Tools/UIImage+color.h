//
//  UIImage+color.h
//  BOSS_CHINA
//
//  Created by cx on 15/9/6.
//  Copyright (c) 2015年 DIGUO HOLDING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;@end
