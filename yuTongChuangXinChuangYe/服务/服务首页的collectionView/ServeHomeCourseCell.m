//
//  ServeHomeCourseCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeCourseCell.h"
#import "ServeHomeFlowLayout.h"
#import "ServeHomeCollectionViewCell.h"

static NSString *cellID = @"HomePageCollectionViewCell";
@interface ServeHomeCourseCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ServeHomeCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.collectionView];
        
    }
    return self;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[ServeHomeFlowLayout alloc] init]];
        [_collectionView registerClass:[ServeHomeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.scrollEnabled=NO;
    }
    return _collectionView;
}
-(void)setCourseArr:(NSMutableArray *)courseArr{
    _courseArr=courseArr;
    CGFloat width=(kScreenWidth-40)/2;
    CGFloat height1=(width*25/33+40);
    _collectionView.frame=CGRectMake(0, 0, kScreenWidth, 2*height1+30);
    [_collectionView reloadData];
}
#pragma mark UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _courseArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServeHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _courseArr[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StarCourseModel_Serve *model=_courseArr[indexPath.row];
    
    if (self.selectAitemBlock) {
        self.selectAitemBlock(model.Id);
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
