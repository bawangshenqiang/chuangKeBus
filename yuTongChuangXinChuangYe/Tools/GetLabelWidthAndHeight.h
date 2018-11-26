//
//  GetLabelWidthAndHeight.h
//  店小二(商家端)
//
//  Created by 霸枪001 on 2017/7/28.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetLabelWidthAndHeight : NSObject

//返回字符串高度
+ (CGFloat)labelHeight:(UILabel*)targetLabel content:(NSString *)_contentString Cellwidth:(CGFloat)_width;
//返回字符串宽度
+ (CGFloat)labelWidth:(UILabel*)targetLabel content:(NSString *)_contentString CellHeight:(CGFloat)_height;

@end
