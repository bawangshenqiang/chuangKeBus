//
//  SearchViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/1.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,copy)void (^BackTitleBlock)(NSString *);
@end

NS_ASSUME_NONNULL_END
