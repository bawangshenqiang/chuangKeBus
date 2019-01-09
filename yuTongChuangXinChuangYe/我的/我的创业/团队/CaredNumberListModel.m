//
//  CaredNumberListModel.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/17.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CaredNumberListModel.h"
extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation CaredNumberListModel
{
    CGFloat _lastContentWidth;
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.Id=[dic[@"id"] intValue];
        self.descriptions=dic[@"description"];
        self.create_time=dic[@"create_time"];
        self.photo=dic[@"photo"];
        self.linker=dic[@"linker"];
        self.linkphone=dic[@"linkphone"];
        self.job=dic[@"job"];
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
        CGRect textRect = [_descriptions boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    return _descriptions;
}


@end
