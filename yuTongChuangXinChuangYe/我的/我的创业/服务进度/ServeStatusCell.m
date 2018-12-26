//
//  ServeStatusCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/14.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeStatusCell.h"

@implementation ServeStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int i=0; i<3; i++) {
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth/6)*(2*i+1)-10, 30, 20, 20)];
            lab.text=[NSString stringWithFormat:@"%d",i];
            lab.font=[UIFont systemFontOfSize:12];
            lab.textAlignment=NSTextAlignmentCenter;
            lab.textColor=RGBAColor(153, 153, 153, 1);
            lab.backgroundColor=RGBAColor(228, 228, 228, 1);
            lab.layer.cornerRadius=10;
            lab.layer.masksToBounds=YES;
            [self.contentView addSubview:lab];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/6)*(2*i+1)-10, 30, 20, 20)];
            imageView.layer.cornerRadius=10;
            imageView.layer.masksToBounds=YES;
            imageView.hidden=YES;
            [self.contentView addSubview:imageView];
            UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*i/3, lab.bottom+10, kScreenWidth/3, 14)];
            title.textAlignment=NSTextAlignmentCenter;
            title.font=[UIFont systemFontOfSize:12];
            title.textColor=RGBAColor(153, 153, 153, 1);
            title.backgroundColor=[UIColor whiteColor];
            [self.contentView addSubview:title];
            if (i==0) {
                self.firstLine=[[UIView alloc]initWithFrame:CGRectMake(lab.right+5, 40, kScreenWidth/3-30, 1)];
                self.firstLine.backgroundColor=RGBAColor(228, 228, 228, 1);
                [self.contentView addSubview:self.firstLine];
                self.firstLab=lab;
                self.firstIV=imageView;
                self.firstTitleLab=title;
                self.firstTitleLab.text=@"待回复";
            }else if (i==1){
                self.secondLine=[[UIView alloc]initWithFrame:CGRectMake(lab.right+5, 40, kScreenWidth/3-30, 1)];
                self.secondLine.backgroundColor=RGBAColor(228, 228, 228, 1);
                [self.contentView addSubview:self.secondLine];
                self.secondLab=lab;
                self.secondIV=imageView;
                self.secondTitleLab=title;
                self.secondTitleLab.text=@"服务中";
            }else{
                self.thirdLab=lab;
                self.thirdIV=imageView;
                self.thirdTitleLab=title;
                self.thirdTitleLab.text=@"服务完成";
            }
        }
    }
    return self;
}
/** 0-待回复 1-服务中 2-服务完成 3-评价完成 4-服务关闭(已拒绝) */
-(void)setStatus:(int)status{
    switch (status) {
        case 0:
            self.firstIV.hidden=YES;
            self.firstLab.backgroundColor=RGBAColor(153, 190, 223, 1);
            self.firstLab.textColor=[UIColor whiteColor];
            self.firstTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.firstTitleLab.text=@"待回复";
            
            break;
        case 1:
            self.firstIV.hidden=NO;
            self.firstIV.image=[UIImage imageNamed:@"evaluate_confirm"];
            self.firstTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.firstTitleLab.text=@"已确认";
            self.secondIV.hidden=YES;
            self.secondLab.backgroundColor=RGBAColor(153, 190, 223, 1);
            self.secondLab.textColor=[UIColor whiteColor];
            self.secondTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.firstLine.backgroundColor=RGBAColor(153, 190, 223, 1);
            
            break;
        case 2:
        case 3:
            self.firstIV.hidden=NO;
            self.firstIV.image=[UIImage imageNamed:@"evaluate_confirm"];
            self.firstTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.firstTitleLab.text=@"已确认";
            self.secondIV.hidden=NO;
            self.secondIV.image=[UIImage imageNamed:@"evaluate_confirm"];
            self.secondTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.thirdIV.hidden=NO;
            self.thirdIV.image=[UIImage imageNamed:@"evaluate_confirm"];
            self.thirdTitleLab.textColor=RGBAColor(0, 92, 175, 1);
            self.firstLine.backgroundColor=RGBAColor(153, 190, 223, 1);
            self.secondLine.backgroundColor=RGBAColor(153, 190, 223, 1);
            
            break;
        case 4:
            self.firstIV.hidden=NO;
            self.firstIV.image=[UIImage imageNamed:@"evaluate_refuse"];
            self.firstTitleLab.textColor=RGBAColor(255, 0, 0, 1);
            self.firstTitleLab.text=@"已拒绝";
            break;
        default:
            break;
    }
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
