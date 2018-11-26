//
//  HomePageImgModel.m
//  易彩票
//
//  Created by 霸枪001 on 2017/11/13.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import "HomePageImgModel.h"

@implementation HomePageImgModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.TopImgUrl=dic[@"cover"];
        self.module=dic[@"module"];
        self.Id=[dic[@"id"] intValue];
    }
    return self;
}
@end
