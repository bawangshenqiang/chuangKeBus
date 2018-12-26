//
//  ServeHomeServiceCell.m
//  yuTongChuangXinChuangYe
//
//  Created by Vdigit on 2018/12/19.
//  Copyright © 2018年 qiyeji. All rights reserved.
//

#import "ServeHomeServiceCell.h"
#import "ServeHomeFlowLayout_2.h"
#import "ServeHomeCollectionViewCell_2.h"

static NSString *cellID = @"HomePageCollectionViewCell_2";
@interface ServeHomeServiceCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ServeHomeServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.collectionView];
        
    }
    return self;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[ServeHomeFlowLayout_2 alloc] init]];
        [_collectionView registerClass:[ServeHomeCollectionViewCell_2 class] forCellWithReuseIdentifier:cellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.scrollEnabled=NO;
    }
    return _collectionView;
}
-(void)setServiceArr:(NSMutableArray *)serviceArr{
    _serviceArr=serviceArr;
    CGFloat width=(kScreenWidth-40)/2;
    CGFloat height2=(width*150/325+25);
    _collectionView.frame=CGRectMake(0, 0, kScreenWidth, 2*height2+40);
    [_collectionView reloadData];
}

#pragma mark UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _serviceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServeHomeCollectionViewCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _serviceArr[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StarCourseModel_Serve *model=_serviceArr[indexPath.row];
    //[kNotificationCenter postNotificationName:@"choseOneLotteryCategoryNotification" object:nil userInfo:@{@"LotteryCategoryModel":model}];
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
