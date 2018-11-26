//
//  ProjectCell_ChuangYe.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ProjectCell_ChuangYe.h"

@implementation ProjectCell_ChuangYe
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 0)];
        self.outBig.backgroundColor=[UIColor whiteColor];
        self.outBig.layer.cornerRadius=5;
        self.outBig.layer.masksToBounds=YES;
        [self.contentView addSubview:self.outBig];
        //
        self.topView=[[ChuangYiCellTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 95)];
        [self.outBig addSubview:self.topView];
        //
        self.statusView=[[CheckStatusView_scroll alloc]initWithFrame:CGRectMake(0, self.topView.bottom, kScreenWidth-20, 30)];
        [self.outBig addSubview:self.statusView];
        
        //
        self.checkIdeaLeft=[[UILabel alloc]initWithFrame:CGRectMake(10, self.statusView.bottom, 60, 15)];
        self.checkIdeaLeft.text=@"审核意见:";
        self.checkIdeaLeft.font=[UIFont systemFontOfSize:13];
        self.checkIdeaLeft.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.outBig addSubview:self.checkIdeaLeft];
        
        //
        _checkIdea=[[UILabel alloc]init];
        _checkIdea.font=[UIFont systemFontOfSize:13];
        _checkIdea.textColor=[UIColor colorWithHexString:@"#323232"];
        [self.outBig addSubview:_checkIdea];
        
        _checkIdea.sd_layout
        .leftSpaceToView(self.checkIdeaLeft, 0)
        .topSpaceToView(self.statusView, 0)
        .rightSpaceToView(self.outBig, 10)
        .autoHeightRatio(0);
        
        self.outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [self.outBig setupAutoHeightWithBottomView:_checkIdea bottomMargin:5];
    }
    return self;
}
-(void)setModel:(ProjectModel_ChuangYe *)model{
    _model=model;
    [self.topView.leftIV sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"picture"]];
    self.topView.rightLab.text=_model.title;
    [self.topView.flagBtn setTitle:_model.flagStr forState:UIControlStateNormal];
    self.topView.studyLab.text=_model.times;
    if (_model.checkModels.count>0) {
        
        self.statusView.checkModels=_model.checkModels;
        
        NSString *string=@"";
        NSString *str1;
        for (int i=0; i<_model.checkModels.count; i++) {
            ProjectCheckModel_ChuangYe *amodel=_model.checkModels[i];
            if (i<_model.checkModels.count-1) {
                str1=[amodel.note stringByAppendingString:@"\n"];
            }else{
                str1=amodel.note;
            }
            string=[string stringByAppendingString:str1];
        }
        
        self.checkIdea.text=string;
    }else{
        self.statusView.checkModels=[@[] mutableCopy];
        self.checkIdea.text=@"等待审核";
    }
    
    [self setupAutoHeightWithBottomView:self.outBig bottomMargin:10];
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
