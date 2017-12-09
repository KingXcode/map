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


@interface HTPoiCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) AMapPOI * poi;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,weak) YYLabel * nameLabel;
@property (nonatomic,weak) YYLabel * typeLabel;
@property (nonatomic,weak) YYLabel * telLabel;
@property (nonatomic,weak) YYLabel * distanceLabel;


@end

@implementation HTPoiCell

-(void)configModel:(AMapPOI *)poi andIndexPath:(NSIndexPath *)indexPath
{
    _poi = poi;
    _indexPath = indexPath;
    _nameLabel.text = poi.name;
    _typeLabel.text = [NSString stringWithFormat:@"类型:   %@",[poi.type stringByReplacingOccurrencesOfString:@";" withString:@"\n类型:   "]];
    _telLabel.text = [NSString stringWithFormat:@"电话号码:   %@",poi.tel];
    _distanceLabel.text = [NSString stringWithFormat:@"距离查询位置:   %zd米",poi.distance];
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
    nameLabel.textColor = [HTColor ht_mianColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    
    YYLabel * typeLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
    typeLabel.textColor = [HTColor textColor_666666];
    typeLabel.numberOfLines = 0;
    typeLabel.font = [UIFont systemFontOfSize:15];
    _typeLabel = typeLabel;
    [self.contentView addSubview:typeLabel];
    
    YYLabel * telLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
    telLabel.textColor = [HTColor textColor_666666];
    telLabel.font = [UIFont systemFontOfSize:15];
    telLabel.numberOfLines = 0;
    _telLabel = telLabel;
    [self.contentView addSubview:telLabel];
    
    YYLabel * distanceLabel = [[YYLabel alloc]initWithFrame:CGRectZero];
    distanceLabel.font = [UIFont systemFontOfSize:15];
    _distanceLabel = distanceLabel;
    [self.contentView addSubview:distanceLabel];
    
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(10);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(self.contentView).mas_offset(15);
        make.right.equalTo(self.contentView).mas_offset(-15);
    }];
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
