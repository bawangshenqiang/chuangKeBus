//
//  HomePageImgModel.h
//  易彩票
//
//  Created by 霸枪001 on 2017/11/13.
//  Copyright © 2017年 霸枪001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageImgModel : NSObject

@property(nonatomic,strong)NSString *TopImgUrl;
@property(nonatomic,strong)NSString *module;
@property(nonatomic,assign)int Id;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
