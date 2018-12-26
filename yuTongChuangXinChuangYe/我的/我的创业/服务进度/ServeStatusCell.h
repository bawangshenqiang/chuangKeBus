//
//  ServeStatusCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServeStatusCell : UITableViewCell
@property(nonatomic,strong)UILabel *firstLab;
@property(nonatomic,strong)UILabel *secondLab;
@property(nonatomic,strong)UILabel *thirdLab;
@property(nonatomic,strong)UIImageView *firstIV;
@property(nonatomic,strong)UIImageView *secondIV;
@property(nonatomic,strong)UIImageView *thirdIV;
@property(nonatomic,strong)UILabel *firstTitleLab;
@property(nonatomic,strong)UILabel *secondTitleLab;
@property(nonatomic,strong)UILabel *thirdTitleLab;
@property(nonatomic,strong)UIView *firstLine;
@property(nonatomic,strong)UIView *secondLine;

@property(nonatomic,assign)int status;
@end

NS_ASSUME_NONNULL_END
