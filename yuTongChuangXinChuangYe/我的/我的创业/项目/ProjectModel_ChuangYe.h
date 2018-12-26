//
//  ProjectModel_ChuangYe.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectCheckModel_ChuangYe.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectModel_ChuangYe : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *flagStr;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,assign)int projectId;
@property(nonatomic,strong)NSString *instructor;
@property(nonatomic,strong)NSString *linkphone;
@property(nonatomic,strong)NSString *status;
/** 项目跳转逻辑 1-详情 0-表单 2-预览 */
@property(nonatomic,strong)NSString *pstatus;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSMutableArray <ProjectCheckModel_ChuangYe *> *checkModels;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
