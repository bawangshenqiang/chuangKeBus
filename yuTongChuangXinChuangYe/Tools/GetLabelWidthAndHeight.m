//
//  GetLabelWidthAndHeight.m
//  店小二(商家端)
//
//  Created by 霸枪001 on 2017/7/28.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "GetLabelWidthAndHeight.h"

@implementation GetLabelWidthAndHeight

+ (CGFloat)labelHeight:(UILabel*)targetLabel content:(NSString *)_contentString Cellwidth:(CGFloat)_width{
    CGFloat height = 0;
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor grayColor];
    lable.numberOfLines = 0;
    lable.textAlignment = targetLabel.textAlignment;
    lable.font = targetLabel.font;
    lable.text = _contentString;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lable.font forKey:NSFontAttributeName];
    CGRect rect = [lable.text boundingRectWithSize:CGSizeMake(_width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
    height = rect.size.height;
    return height;
}
+ (CGFloat)labelWidth:(UILabel*)targetLabel content:(NSString *)_contentString CellHeight:(CGFloat)_height{
    CGFloat width = 0;
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor grayColor];
    lable.numberOfLines = 1;
    lable.textAlignment = targetLabel.textAlignment;
    lable.font = targetLabel.font;
    lable.text = _contentString;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:lable.font forKey:NSFontAttributeName];
    CGRect rect = [lable.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, _height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  attributes:dict context:nil];
    width = rect.size.width;
    return width;
}

@end
