//
//  HTPoiCell.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/12/4.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

/*
 ///名称
 @property (nonatomic, copy)   NSString     *name;
 ///兴趣点类型
 @property (nonatomic, copy)   NSString     *type;
 ///电话
 @property (nonatomic, copy)   NSString     *tel;
 ///距中心点的距离，单位米。在周边搜索时有效
 @property (nonatomic, assign) NSInteger     distance;
 ///图片列表
 @property (nonatomic, strong) NSArray<AMapImage *> *images;

 */

#import "HTPoiCell.h"
#import <SDCycleScrollView.h>


@interface HTPoiCell()
@property (nonatomic,strong) AMapPOI * poi;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,weak) YYLabel * nameLabel;
@property (nonatomic,weak) YYLabel * typeLabel;
@property (nonatomic,weak) YYLabel * telLabel;
@property (nonatomic,weak) YYLabel * distanceLabel;
@property (nonatomic,weak) SDCycleScrollView * scorllImages;


@end

@implementation HTPoiCell

-(void)configModel:(AMapPOI *)poi andIndexPath:(NSIndexPath *)indexPath
{
    _poi = poi;
    _indexPath = indexPath;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    YYLabel * nameLabel = [[YYLabel alloc]initWithFrame:CGRectZero];

    
    YYLabel * typeLabel = [[YYLabel alloc]initWithFrame:CGRectZero];

    
    YYLabel * telLabel = [[YYLabel alloc]initWithFrame:CGRectZero];

    
    YYLabel * distanceLabel = [[YYLabel alloc]initWithFrame:CGRectZero];

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
