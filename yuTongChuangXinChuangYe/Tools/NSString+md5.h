//
//  NSString+md5.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (md5)
/**
 *  md5加密的字符串
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *) md5:(NSString *) str;
@end

NS_ASSUME_NONNULL_END
