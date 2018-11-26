//
//  shareSmallLzhGroupView.m
//  易彩票
//
//  Created by corill002 on 2018/1/30.
//  Copyright © 2018年 霸枪001. All rights reserved.
//

#import "shareSmallLzhGroupView.h"

@implementation shareSmallLzhGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width * 0.8, frame.size.width * 0.8)];
        _topImageView.backgroundColor = [UIColor grayColor];
        _topImageView.center = CGPointMake(frame.size.width / 2, _topImageView.centerY);
        _topImageView.layer.cornerRadius = _topImageView.width / 2;
        [self addSubview:_topImageView];
        //
        _botLabel = [[UILabel alloc]init];
        _botLabel.frame = CGRectMake(0, _topImageView.bottom + 5, frame.size.width, frame.size.height * 0.2 - 5);
        _botLabel.font=[UIFont systemFontOfSize:11];
        _botLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_botLabel];
        //
        self.backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.backButt];
        
    }
    return self;
}
//

//
@end
