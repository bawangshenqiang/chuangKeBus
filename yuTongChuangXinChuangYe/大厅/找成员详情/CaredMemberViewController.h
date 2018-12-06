//
//  CaredMemberViewController.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaredMemberViewController : UIViewController
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)void (^callBackBlock)(void);
@end

NS_ASSUME_NONNULL_END
