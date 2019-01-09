//
//  InterestModel_Public.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/25.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "InterestModel_Public.h"
extern CGFloat maxContentLabelHeight2;
@implementation InterestModel_Public
{
    CGFloat _lastContentWidth;
}
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.findTeamUserId=[dic[@"teamId"] intValue];
        self.title=dic[@"title"];
        self.job=dic[@"job"];
        self.descriptions=dic[@"description"];
        self.create_time=dic[@"create_time"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
    }
    return self;
}
@synthesize descriptions = _descriptions;

-(void)setDescriptions:(NSString *)descriptions{
    _descriptions=descriptions;
}
-(NSString *)descriptions{
    
    CGFloat contentW = kScreenWidth-51;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_descriptions boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        if (textRect.size.height > maxContentLabelHeight2) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    return _descriptions;
}

@end
