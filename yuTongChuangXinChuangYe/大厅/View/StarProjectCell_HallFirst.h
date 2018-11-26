//
//  StarProjectCell_HallFirst.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/16.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel_video.h"
#import "Hall_HomeStarProject.h"
#import "StarCourseModel_Serve.h"

NS_ASSUME_NONNULL_BEGIN

@interface StarProjectCell_HallFirst : UITableViewCell
@property(nonatomic,strong)UIView *outBig;
@property(nonatomic,strong)UIImageView *leftIV;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UIButton *flagBtn;
@property(nonatomic,strong)UILabel *studyLab;
@property(nonatomic,strong)Hall_HomeStarProject *model_starProject;
@property(nonatomic,strong)CourseModel_video *model_video;
@property(nonatomic,strong)StarCourseModel_Serve *model_serve;

@end

NS_ASSUME_NONNULL_END
