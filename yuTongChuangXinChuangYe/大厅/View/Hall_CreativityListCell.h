//
//  Hall_CreativityListCell.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/5.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCreativityListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hall_CreativityListCell : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UILabel *descriptionLab;
@property(nonatomic,strong)UIButton *flagBtn;
@property(nonatomic,strong)UILabel *studyLab;
@property(nonatomic,strong)SearchCreativityListModel *model;

@end

NS_ASSUME_NONNULL_END
