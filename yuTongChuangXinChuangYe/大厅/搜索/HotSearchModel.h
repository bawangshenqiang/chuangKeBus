//
//  HotSearchModel.h
//  Dianxiaoer
//
//  Created by 霸枪001 on 2017/7/18.
//
//

#import <Foundation/Foundation.h>

@interface HotSearchModel : NSObject

@property(nonatomic,copy)NSString *resName;
@property(nonatomic,assign)int resID;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
