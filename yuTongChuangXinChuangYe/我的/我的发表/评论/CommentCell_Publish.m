//
//  CommentCell_Publish.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/10/24.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "CommentCell_Publish.h"

@implementation CommentCell_Publish
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.outBig=[[UIView alloc]init];
        self.outBig.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:self.outBig];
        //
        _leftLab=[[UILabel alloc]init];
        _leftLab.text=@"评论";
        _leftLab.font=[UIFont systemFontOfSize:16];
        [self.outBig addSubview:_leftLab];
        //
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=[UIFont systemFontOfSize:16];
        _nameLab.textColor=kThemeColor;
        [self.outBig addSubview:_nameLab];
        //
        _commentView=[[UIView alloc]init];
        _commentView.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
        [self.outBig addSubview:_commentView];
        //
        _commentLab=[[UILabel alloc]init];
        _commentLab.font=[UIFont systemFontOfSize:14];
        _commentLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _commentLab.backgroundColor=[UIColor colorWithHexString:@"#f2f2f2"];
        _commentLab.numberOfLines=0;
        [_commentView addSubview:_commentLab];
        //
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=[UIFont systemFontOfSize:10];
        _timeLab.textColor=[UIColor colorWithHexString:@"#989898"];
        _timeLab.textAlignment=NSTextAlignmentRight;
        [self.outBig addSubview:_timeLab];
        
        _outBig.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .topEqualToView(self.contentView)
        .widthIs(kScreenWidth-20);
        [_outBig setupAutoHeightWithBottomView:_timeLab bottomMargin:0];
        _outBig.sd_cornerRadius=@(5);
        
        _leftLab.sd_layout
        .leftSpaceToView(self.outBig, 10)
        .topSpaceToView(self.outBig, 10)
        .heightIs(15);
        [_leftLab setSingleLineAutoResizeWithMaxWidth:50];
        
        _nameLab.sd_layout
        .leftSpaceToView(self.leftLab, 10)
        .topEqualToView(self.leftLab)
        .heightIs(15)
        .widthIs(kScreenWidth-20-self.leftLab.right-30);
        
        _commentView.sd_layout
        .leftEqualToView(self.leftLab)
        .topSpaceToView(self.leftLab, 10)
        .widthIs(kScreenWidth-40);
        [_commentView setupAutoHeightWithBottomView:_commentLab bottomMargin:10];
        _commentView.sd_cornerRadius=@(5);
        
        _commentLab.sd_layout
        .leftSpaceToView(self.commentView, 10)
        .topSpaceToView(self.commentView, 10)
        .widthIs(kScreenWidth-60)
        .autoHeightRatio(0);
        
        _timeLab.sd_layout
        .rightSpaceToView(self.outBig, 10)
        .topSpaceToView(self.commentView, 0)
        .heightIs(20);
        [_timeLab setSingleLineAutoResizeWithMaxWidth:100];
        
    }
    return self;
}
-(void)setModel:(CommentModel_Publish *)model{
    _model=model;
    
    self.nameLab.text=_model.title;
    
    self.commentLab.text=_model.comment;
    
    self.timeLab.text=_model.create_time;
    
    
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
