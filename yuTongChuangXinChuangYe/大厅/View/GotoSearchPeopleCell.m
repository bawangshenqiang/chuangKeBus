//
//  GotoSearchPeopleCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/18.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "GotoSearchPeopleCell.h"

@implementation GotoSearchPeopleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.topTitle.text=@"这家公司要用设计+AI创造新时代！这家公司要用设计+AI创造新时代！这家公司要用设计+AI创造新时代！";
        self.flag1IV.image=[UIImage imageNamed:@"team_name"];
        self.flag1Lab.text=@"藤顺娟娟";
        self.flag2IV.image=[UIImage imageNamed:@"team_position"];
        self.flag2Lab.text=@"企业极人事";
        self.flag3IV.image=[UIImage imageNamed:@"team_industry"];
        self.flag3Lab.text=@"教育";
        self.timeLab.text=@"20分钟前";
    }
    return self;
}
-(void)setModel:(SearchNumbersListModel_Hall *)model{
    _model=model;
    self.topTitle.text=_model.title;
    self.flag1Lab.text=_model.name;
    self.flag2Lab.text=_model.job;
    self.flag3Lab.text=_model.category;
    self.timeLab.text=_model.create_time;
}
- (UIView *)outBig{
    if (!_outBig) {
        _outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 70)];
        //_outBig.backgroundColor=[UIColor whiteColor];
        _outBig.layer.cornerRadius=5;
        _outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:_outBig];
    }
    return _outBig;
}
-(UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.outBig.width-20, 45)];
        _topTitle.numberOfLines=2;
        _topTitle.font=[UIFont systemFontOfSize:15];
        _topTitle.textColor=[UIColor colorWithHexString:@"#232323"];
        [self.outBig addSubview:_topTitle];
    }
    return _topTitle;
}
-(UIImageView *)flag1IV{
    if (!_flag1IV) {
        _flag1IV=[[UIImageView alloc]init];
        //_flag1IV.image=[UIImage imageNamed:@"team_name"];
        [self.outBig addSubview:_flag1IV];
        _flag1IV.sd_layout
        .leftEqualToView(self.topTitle)
        .topSpaceToView(self.topTitle, 7)
        .widthIs(10)
        .heightIs(10);
    }
    return _flag1IV;
}
-(UILabel *)flag1Lab{
    if (!_flag1Lab) {
        _flag1Lab=[[UILabel alloc]init];
        _flag1Lab.font=[UIFont systemFontOfSize:10];
        _flag1Lab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:_flag1Lab];
        _flag1Lab.sd_layout
        .leftSpaceToView(self.flag1IV, 5)
        .centerYEqualToView(self.flag1IV)
        .heightIs(10);
        [_flag1Lab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _flag1Lab;
}
-(UIImageView *)flag2IV{
    if (!_flag2IV) {
        _flag2IV=[[UIImageView alloc]init];
        //_flag2IV.image=[UIImage imageNamed:@"team_position"];
        [self.outBig addSubview:_flag2IV];
        _flag2IV.sd_layout
        .leftSpaceToView(self.flag1Lab, 10)
        .topSpaceToView(self.topTitle, 7)
        .widthIs(5)
        .heightIs(10);
    }
    return _flag2IV;
}
-(UILabel *)flag2Lab{
    if (!_flag2Lab) {
        _flag2Lab=[[UILabel alloc]init];
        _flag2Lab.font=[UIFont systemFontOfSize:10];
        _flag2Lab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:_flag2Lab];
        _flag2Lab.sd_layout
        .leftSpaceToView(self.flag2IV, 5)
        .centerYEqualToView(self.flag2IV)
        .heightIs(10);
        [_flag2Lab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _flag2Lab;
}
-(UIImageView *)flag3IV{
    if (!_flag3IV) {
        _flag3IV=[[UIImageView alloc]init];
        //_flag3IV.image=[UIImage imageNamed:@"team_industry"];
        [self.outBig addSubview:_flag3IV];
        _flag3IV.sd_layout
        .leftSpaceToView(self.flag2Lab, 10)
        .topSpaceToView(self.topTitle, 7)
        .widthIs(5)
        .heightIs(10);
    }
    return _flag3IV;
}
-(UILabel *)flag3Lab{
    if (!_flag3Lab) {
        _flag3Lab=[[UILabel alloc]init];
        _flag3Lab.font=[UIFont systemFontOfSize:10];
        _flag3Lab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:_flag3Lab];
        _flag3Lab.sd_layout
        .leftSpaceToView(self.flag3IV, 5)
        .centerYEqualToView(self.flag3IV)
        .heightIs(10);
        [_flag3Lab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _flag3Lab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:10];
        _timeLab.textAlignment=NSTextAlignmentRight;
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        [self.outBig addSubview:_timeLab];
        _timeLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .centerYEqualToView(self.flag1Lab)
        .heightIs(10);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:120];
    }
    return _timeLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
