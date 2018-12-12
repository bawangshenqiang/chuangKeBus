//
//  SJTool.m
//  KR管理系统
//
//  Created by 霸枪001 on 2017/9/21.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "SJTool.h"
#import <sys/utsname.h>

@implementation SJTool

+(void)showAlertWithMessage:(NSString *)message with:(UIViewController *)viewController{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [viewController presentViewController:alert animated:YES completion:nil];
}
+(void)showAlertThenBackWithMessage:(NSString *)message with:(UIViewController *)viewController{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [viewController.navigationController popViewControllerAnimated:YES];
    }]];
    
    
    [viewController presentViewController:alert animated:YES completion:nil];
}
+ (void)showAlertWithText:(NSString *)text
{
    UIView *alert = [UIView new];
    alert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [alert addSubview:label];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
    alert.sd_layout
    .centerXEqualToView(alert.superview)
    .centerYEqualToView(alert.superview)
    .widthIs(200);
    [alert setupAutoHeightWithBottomView:label bottomMargin:20];
    
    alert.sd_cornerRadius = @(5);
    
    label.sd_layout
    .centerXEqualToView(alert)
    .widthRatioToView(alert, 1)
    .topSpaceToView(alert, 20)
    .autoHeightRatio(0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert removeFromSuperview];
    });
}
+(BOOL)textFieldShouldBeginEditing:(UITextField *)textField withView:(UIView *)view{
    NSTimeInterval animationDuration=0.5f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = kScreenWidth;
    float height = kScreenHeight;
    //上移n个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-216.0f,width,height);
    view.frame=rect;
    [UIView commitAnimations];
    return YES;
}
+(BOOL)textFieldShouldEndEditing:(UITextField *)textField withView:(UIView *)view{
    NSTimeInterval animationDuration=0.5f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = kScreenWidth;
    float height = kScreenHeight;
    
    CGRect rect=CGRectMake(0.0f,0.0f,width,height);
    view.frame=rect;
    [UIView commitAnimations];
    
    return YES;
}
+(UIView *)backToolBarView{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    
    [topView setItems:buttonsArray];
    return topView;
}
+(void)dismissKeyBoard{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissKeyBoard" object:nil];
    
}
+ (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    
    return str;
}
//生成16位随机字符串
+ (NSString *)shuffledAlphabet {
    NSString *alphabet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:16];
    free(characters);
    return result;
}


+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    //若要加去空格操作，range换成range2
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];
    
    return mutStr;
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSDictionary *)dictionaryWithResponse:(id)response{
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//+(NSArray *)encryptWithDictionary:(NSDictionary *)d{
//    //RSA
//    NSString *randomkey=[SJTool shuffledAlphabet];
//    NSString *encryptStr = [RSAEncryptor encryptString:randomkey publicKey:RSA_Public_key];
//
//    //AES
//    NSString *jsonStr=[SJTool convertToJsonData:d];
//    NSString *aesStr=[AES128Util AES128Encrypt:jsonStr key:randomkey];
//
//    NSArray *array=@[aesStr,encryptStr,randomkey];
//    return array;
//}
//
//+(NSDictionary *)resolvingWith:(id)response param:(NSString *)parg{
//    //NSString *backStr=[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
//    //NSLog(@"返回的内容:%@",backStr);
//    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
//    NSString *param1=@"";
//    NSString *param2=@"";
//    if ([dict.allKeys containsObject:@"P1"]&&[dict.allKeys containsObject:@"P2"]) {
//        param1=dict[@"P1"];
//        param2=dict[@"P2"];
//    }
//
//
//    HBRSAHandler* handler = [HBRSAHandler new];
//    [handler importKeyWithType:KeyTypePublic andkeyString:RSA_Public_key];
//    BOOL flag=[handler verifyString:[NSString md5:param1] withSign:param2];
//
//    //验签
//    if (flag) {
//        NSString *decryptP1Str=[AES128Util AES128Decrypt:param1 key:parg];
//        //NSLog(@"解密后的json字符串:%@",decryptP1Str);
//        NSDictionary *dic=[SJTool dictionaryWithJsonString:decryptP1Str];
//        if (dic==nil) {
//            NSLog(@"解密后的dic是nil");
//        }else{
//            NSLog(@"解密后的dic:%@",[SJTool logDic:dic]);
//        }
//        return dic;
//    }else{
//        return nil;
//    }
//
//}
//通过年月求每月天数
+ (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0 ? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            
            return 30;
        }
        case 2:{
            if (isrunNian) {
                
                return 29;
            }else{
                
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}
+(void)showBigImage:(NSArray *)arr{
    
    UIView *filter=[[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    filter.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [[UIApplication sharedApplication].keyWindow addSubview:filter];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenWidth*4/3)];
    if (arr.count==0) {
        scrollView.contentSize=CGSizeMake(kScreenWidth, 0);
        
    }else{
        scrollView.contentSize=CGSizeMake(kScreenWidth*arr.count, 0);
        
    }
    
    scrollView.bounces=NO;
    scrollView.pagingEnabled=YES;
    
    [filter addSubview:scrollView];
    
    
    
    if (arr.count==0) {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollView.height)];
        imageview.userInteractionEnabled=YES;
        imageview.image=[UIImage imageNamed:@"bg_item@2x"];
        imageview.contentMode=UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageview];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageClick:)];
        [imageview addGestureRecognizer:tap];
    }else{
        
        for (int i=0; i<arr.count; i++) {
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth*i), 0, kScreenWidth, scrollView.height)];
            imageview.userInteractionEnabled=YES;
            [imageview sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"bg_item@2x"]];
            imageview.contentMode=UIViewContentModeScaleAspectFit;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageClick:)];
            [imageview addGestureRecognizer:tap];
            [scrollView addSubview:imageview];
            
            
            UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-80*kBaseWidth)/2+kScreenWidth*i, scrollView.height-40*kBaseWidth, 80*kBaseWidth, 20*kBaseWidth)];
            titleLabel.text=[NSString stringWithFormat:@"第%d页共%ld页",i+1,arr.count];
            titleLabel.backgroundColor=[UIColor clearColor];
            titleLabel.textColor=kThemeColor;
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.font=[UIFont systemFontOfSize:12];
            [scrollView addSubview:titleLabel];
            
            
        }
        
    }
    
}
+(void)tapImageClick:(UITapGestureRecognizer *)tapGesture{
    UIView *view=tapGesture.view.superview.superview;
    [view removeFromSuperview];
    view=nil;
}

+(void)getAuthcodeClick:(UIButton *)l_timeButton{
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
                
                [l_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                l_timeButton.titleLabel.font=[UIFont systemFontOfSize:17];
                //设置可点击
                l_timeButton.userInteractionEnabled = YES;
                
                
            });
        }else{
            //            int minutes = timeout / 60;    //这里注释掉了，这个是用来测试多于60秒时计算分钟的。
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@s后重新获取",strTime] forState:UIControlStateNormal];
                l_timeButton.titleLabel.font=[UIFont systemFontOfSize:12];
                //设置不可点击
                l_timeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
    
}

/**
 
 * 网址正则验证 1或者2使用哪个都可以
 
 *
 
 *  @param string 要验证的字符串
 
 *
 
 *  @return 返回值类型为BOOL
 
 */
- (BOOL)urlValidation:(NSString *)string {
    
    NSError *error;
    
    // 正则1
    
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    
    // 正则2
    
    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                  
                                                                           options:NSRegularExpressionCaseInsensitive
                                  
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        
        NSString* substringForMatch = [string substringWithRange:match.range];
        
        NSLog(@"%@",substringForMatch);
        
        return YES;
        
    }
    return NO;
}

//去设置页面
+ (void)gotoSetting:(UIViewController *)vc{
    NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
    NSString *message = [NSString stringWithFormat:@"请在%@的\"设置-隐私-通讯录\"选项中，\r允许%@访问你的通讯录。",[UIDevice currentDevice].model,appName];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancleAction];
    [alertVC addAction:sureAction];
    [vc presentViewController:alertVC animated:YES completion:nil];
}
+ (BOOL)isMobile:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    
    //    联通号段:130/131/132/155/156/185/186/145/176
    
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
    
}
+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}
#pragma mark--日期选为本月第一天和最后一天算法

+ (NSString *)getMonthBeginWith:(NSString *)dateStr{
    
    
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM"];
    
    NSDate *newDate=[format dateFromString:dateStr];
    
    double interval = 0;
    
    NSDate *beginDate = nil;
    
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    
    if (ok) {
        
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        
    }else {
        
        return @"";
        
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    
    return beginString;
    
}

+ (NSString *)getMonthEndWith:(NSString *)dateStr{
    
    
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM"];
    
    NSDate *newDate=[format dateFromString:dateStr];
    
    double interval = 0;
    
    NSDate *beginDate = nil;
    
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    
    if (ok) {
        
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        
    }else {
        
        return @"";
        
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    return endString;
    
}
//清除缓存
//真机清理Cache缓存有坑,Snapshots文件夹无操作权限,导致清理失败,提供的方法中已经做了过滤处理
+ (NSUInteger)getSize{
    NSUInteger size = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        if (![filePath containsString:@"/Caches/Snapshots"]) {
            NSDictionary *attrs = [fileManager attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
        
    }
    return size;
}
+ (NSString *)cacheSizeStr:(NSInteger)totalSize{
    
    NSString *sizeStr = @"清除缓存";
    if (totalSize > 1000 * 1000) {
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, sizeF];
    } else if (totalSize > 1000) {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeF];
    } else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)", sizeStr, totalSize];
    }
    return sizeStr;
}
+ (void)clearFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        if (![filePath containsString:@"/Caches/Snapshots"]) {
            
            [fileManager removeItemAtPath:filePath error:nil];
        }
        
    }
}

//指定宽度按比例缩放
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

//1、等比例压缩 裁剪出的图片是以asize最小值为边框的正方形图片
//修改图片尺寸 同比缩放
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            
            
            rect.size.height = asize.height;
            
            
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            
            
            rect.origin.y = 0;
            
            
            
        }
        
        else{
            
            
            
            rect.size.width = asize.width;
            
            
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            
            
            rect.origin.x = 0;
            
            
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
            
            
        }
        
        
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}



//2、简单粗暴地图片裁剪方法 裁剪出的图片尺寸按照size的尺寸，但图片可能会被拉伸
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    
    
    if (nil == image) {
        
        
        
        newimage = nil;
        
        
        
    }
    
    
    
    else{
        
        
        
        UIGraphicsBeginImageContext(asize);
        
        
        
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        
        
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        UIGraphicsEndImageContext();
        
        
        
    }
    
    
    
    return newimage;
    
}

//3、裁剪出的图片尺寸按照size的尺寸，但图片不拉伸，但多余部分会被裁减掉
+ (UIImage *)thumbnailNotStretchWithImage:(UIImage *)originalImage size:(CGSize)size

{
    
    CGSize originalsize = [originalImage size];
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    
    if (originalsize.width<size.width && originalsize.height<size.height)
        
    {
        
        return originalImage;
        
    }
    
    
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    
    else if(originalsize.width>size.width && originalsize.height>size.height)
        
    {
        
        CGFloat rate = 1.0;
        
        CGFloat widthRate = originalsize.width/size.width;
        
        CGFloat heightRate = originalsize.height/size.height;
        
        
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        
        
        CGImageRef imageRef = nil;
        
        
        
        if (heightRate>widthRate)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
            
        }
        
        else
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
            
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    
    else if(originalsize.height>size.height || originalsize.width>size.width)
        
    {
        
        CGImageRef imageRef = nil;
        
        
        
        if(originalsize.height>size.height)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
            
        }
        
        else if (originalsize.width>size.width)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
            
        }
        
        
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图为标准长宽的，不做处理
    
    else
        
    {
        
        return originalImage;
        
    }
    
    
    
}
//获取当前时间戳 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

//
+(NSString *)getToken{
    NSString *token=@"yutongapp";
    NSString *stempStr=[SJTool getNowTimeTimestamp3];
    token=[token stringByAppendingString:stempStr];
    token=[token stringByAppendingString:@"phoenix"];
    token=[NSString md5:token];
    return token;
}
@end
