//
//  ProviderCell_Hall.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/10.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCourseModel_Serve.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProviderCell_Hall : UITableViewCell
@property(nonatomic,strong)NSMutableArray *providerData;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,copy)void (^btnClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
