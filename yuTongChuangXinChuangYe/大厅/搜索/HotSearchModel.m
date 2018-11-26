//
//  HotSearchModel.m
//  Dianxiaoer
//
//  Created by 霸枪001 on 2017/7/18.
//
//

#import "HotSearchModel.h"

@implementation HotSearchModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.resName=dic[@"ResName"];
        self.resID=[dic[@"ResID"] intValue];
        
    }
    return self;
}


@end
