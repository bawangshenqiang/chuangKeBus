//
//  FastInfoListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/23.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FastInfoListModel : NSObject
@property(nonatomic,assign)BOOL showBottomView;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detailTitle;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,strong)NSString *fromStr;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
