//
//  LoadDisplayViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 如果真机测试的时候连着电脑，webview打开.docx文件会崩溃，原因是开着全局断点，关闭全局断点就OK了
 */
@interface LoadDisplayViewController : UIViewController
@property(nonatomic,strong)NSString *loadUrl;
@end

NS_ASSUME_NONNULL_END
