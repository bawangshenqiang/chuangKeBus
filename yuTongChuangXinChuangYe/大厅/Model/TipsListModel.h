//
//  TipsListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/12.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipsListModel : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *url;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
