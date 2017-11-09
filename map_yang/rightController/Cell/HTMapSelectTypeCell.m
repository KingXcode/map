//
//  HTMapSelectTypeCell.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/9.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMapSelectTypeCell.h"
#import <Masonry.h>
#import "HTMapTypeCell.h"

@interface HTMapSelectTypeModel:NSObject
@property (nonatomic,copy) NSString * name;
@property (nonatomic,strong) UIImage * image;
@property (nonatomic,copy) NSNumber * type;
- (instancetype)initWithName:(NSString *)name AndType:(NSNumber *)type AndImageName:(NSString *)imageName;
@end

@implementation HTMapSelectTypeModel
- (instancetype)initWithName:(NSString *)name AndType:(NSNumber *)type AndImageName:(NSString *)imageName
{
    self = [super init];
    if (self) {
        _name = name.copy;
        _type = type.copy;
        _image = [UIImage imageNamed:imageName];
    }
    return self;
}
@end

@interface HTMapSelectTypeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView * collectionview;
@property (nonatomic,weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,copy) NSArray * dataArray;
@end

@implementation HTMapSelectTypeCell

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        HTMapSelectTypeModel *model_0 = [[HTMapSelectTypeModel alloc]initWithName:@"普通地图" AndType:@(0) AndImageName:@"map_0"];
        HTMapSelectTypeModel *model_1 = [[HTMapSelectTypeModel alloc]initWithName:@"卫星地图" AndType:@(1) AndImageName:@"map_1"];
        HTMapSelectTypeModel *model_2 = [[HTMapSelectTypeModel alloc]initWithName:@"夜间视图" AndType:@(2) AndImageName:@"map_2"];
//        HTMapSelectTypeModel *model_3 = [[HTMapSelectTypeModel alloc]initWithName:@"导航视图" AndType:@(3) AndImageName:@""];
        HTMapSelectTypeModel *model_4 = [[HTMapSelectTypeModel alloc]initWithName:@"公交视图" AndType:@(4) AndImageName:@"map_4"];
        _dataArray = @[model_0,model_1,model_2,model_4];
    }
    return _dataArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(void)creatUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"HTMapTypeCell" bundle:nil] forCellWithReuseIdentifier:@"HTMapTypeCell"];
    
    self.flowLayout = flowLayout;
    self.collectionview = collectionView;
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTMapTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTMapTypeCell" forIndexPath:indexPath];
    HTMapSelectTypeModel *model = self.dataArray[indexPath.item];
    cell.titleLabel.text = model.name;
    cell.imageView.image = model.image;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HTMapSelectTypeModel *model = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(didselectType:)]) {
        [self.delegate didselectType:model.type.integerValue];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(88, 88);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}









@end
