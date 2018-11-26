//
//  PullDownCell_Publish.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/29.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"
NS_ASSUME_NONNULL_BEGIN

@interface PullDownCell_Publish : UITableViewCell
@property(nonatomic,strong)LMJDropdownMenu *choseStyle;
@property(nonatomic,strong)NSMutableArray *titleArr;
@end

NS_ASSUME_NONNULL_END
