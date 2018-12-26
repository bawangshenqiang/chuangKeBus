//
//  TaskCenterCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCenterCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UILabel *topScore;
@property(nonatomic,strong)UILabel *bottomTitle;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UILabel *completeLab;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)void (^btnClickBlock)(NSString *string,NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
