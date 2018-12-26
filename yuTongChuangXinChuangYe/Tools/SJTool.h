//
//  SJTool.h
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/21.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompleteBlock)();

@interface SJTool : NSObject

@property(nonatomic,copy)CompleteBlock completeblock;

+(void)showAlertWithMessage:(NSString *)message with:(UIViewController *)viewController;
+(void)showAlertThenBackWithMessage:(NSString *)message with:(UIViewController *)viewController;
+ (void)showAlertWithText:(NSString *)text;


+(BOOL)textFieldShouldBeginEditing:(UITextField *)textField withView:(UIView *)view;
+(BOOL)textFieldShouldEndEditing:(UITextField *)textField withView:(UIView *)view;

+(UIView *)backToolBarView;

//打印中文
+ (NSString *)logDic:(NSDictionary *)dic;

//生成16位随机字符串
+ (NSString *)shuffledAlphabet;

//字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSDictionary *)dictionaryWithResponse:(id)response;
//加密
+(NSArray *)encryptWithDictionary:(NSDictionary *)d;

//解析
+(NSDictionary *)resolvingWith:(id)response param:(NSString *)parg;

//通过年月求每月天数
+ (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month;

+(void)showBigImage:(NSArray *)arr;

//获取验证码的倒计时
+(void)getAuthcodeClick:(UIButton *)l_timeButton;

//网址正则验证
+ (BOOL)urlValidation:(NSString *)string;

//去设置页面
+ (void)gotoSetting:(UIViewController *)vc place:(NSString *)place;

//验证手机号合法性
+ (BOOL)isMobile:(NSString *)mobileNum;
//渐变色
+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor;
//获取手机型号
+ (NSString*)iphoneType;

#pragma mark--日期选为本月第一天和最后一天算法

+ (NSString *)getMonthBeginWith:(NSString *)dateStr;
+ (NSString *)getMonthEndWith:(NSString *)dateStr;

//清除缓存 cache
+ (NSUInteger)getSize;
+ (NSString *)cacheSizeStr:(NSInteger)totalSize;
+ (void)clearFile;

//指定宽度按比例缩放
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

//1、等比例压缩 裁剪出的图片是以asize最小值为边框的正方形图片
//修改图片尺寸 同比缩放
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

//2、简单粗暴地图片裁剪方法 裁剪出的图片尺寸按照size的尺寸，但图片可能会被拉伸
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

//3、裁剪出的图片尺寸按照size的尺寸，但图片不拉伸，但多余部分会被裁减掉
+ (UIImage *)thumbnailNotStretchWithImage:(UIImage *)originalImage size:(CGSize)size;

//获取当前时间戳 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3;

//获取token
+(NSString *)getToken;


@end
