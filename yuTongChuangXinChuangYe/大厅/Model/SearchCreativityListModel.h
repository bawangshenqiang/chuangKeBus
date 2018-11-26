//
//  SearchCreativityListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/11/2.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCreativityListModel : NSObject
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *category;//分类
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *descriptions;
@property(nonatomic,strong)NSString *create_time;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
