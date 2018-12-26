//
//  RankingListModel.h
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/13.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankingListModel : NSObject
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,assign)int score;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
