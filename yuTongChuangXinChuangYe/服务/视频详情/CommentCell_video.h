//
//  CommentCell_video.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/26.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel_video.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell_video : UITableViewCell
@property(nonatomic,strong)UIImageView *headIV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)CommentModel_video *model;
@end

NS_ASSUME_NONNULL_END
