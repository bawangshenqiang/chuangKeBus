//
//  CatalogCell_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatalogModel_video.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatalogCell_video : UITableViewCell
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)CatalogModel_video *model;

@end

NS_ASSUME_NONNULL_END
