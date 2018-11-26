//
//  CommentCell_Publish.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel_Publish.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell_Publish : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UIView *commentView;
@property(nonatomic,strong)UILabel *commentLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)CommentModel_Publish *model;
@end

NS_ASSUME_NONNULL_END
