//
//  IntroduceWebviewCell_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "IntroduceWebviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IntroduceWebviewCell_video : UITableViewCell<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)IntroduceWebviewModel *model;

@end

NS_ASSUME_NONNULL_END
