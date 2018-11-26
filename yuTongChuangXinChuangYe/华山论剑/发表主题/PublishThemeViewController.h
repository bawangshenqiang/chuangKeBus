//
//  PublishThemeViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishThemeViewController : UIViewController
@property(nonatomic,assign)BOOL isRevise;//修改
@property(nonatomic,assign)int postId;
@property(nonatomic,strong)NSMutableArray *themeArr;
@end

NS_ASSUME_NONNULL_END
