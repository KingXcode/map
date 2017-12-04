//
//  HTPOIDetailInfoHeaderView.m
//  map_yang
//
//  Created by niesiyang on 2017/11/19.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIDetailInfoHeaderView.h"
#import <SDCycleScrollView.h>
#import "HTPOIDetailInfoSubView.h"

@interface HTPOIDetailInfoHeaderView()<SDCycleScrollViewDelegate>
@property (nonatomic,weak) SDCycleScrollView * scorllImages;
@property (nonatomic,weak) HTPOIDetailInfoSubView * subView;
@end

@implementation HTPOIDetailInfoHeaderView

-(void)configData:(AMapPOI *)poi
{
    _poi = poi;
    if (_poi.images.count>0)
    {
        self.scorllImages.hidden = NO;
        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *images = [NSMutableArray array];
        for (AMapImage *mapImage in _poi.images) {
            NSString *title = mapImage.title.length > 1 ?mapImage.title:_poi.name;
            NSString *image = mapImage.url              ?mapImage.url:@"";
            [titles addObject:title];
            [images addObject:image];
        }
        self.scorllImages.imageURLStringsGroup = images;
        self.scorllImages.titlesGroup = titles;
        [self.subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(IphoneWidth*9/16);
        }];
        
    }
    else
    {
        self.scorllImages.hidden = YES;
        [self.subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(0);
        }];
    }
    
    self.subView.addressLabel.text         = _poi.address.length      > 1 ?_poi.address      : @"---";
    self.subView.emailLabel.text           = _poi.email.length        > 1 ?_poi.email        : @"---";
    self.subView.telLabel.text             = _poi.tel.length          > 1 ?_poi.tel          : @"---";
    self.subView.postcodeLabel.text        = _poi.postcode.length     > 1 ?_poi.postcode     : @"---";
    self.subView.websiteLabel.text         = _poi.website.length      > 1 ?_poi.website      : @"---";
    self.subView.businessAreaLabel.text    = _poi.businessArea.length > 1 ?_poi.businessArea : @"---";
    
    
    [self layoutIfNeeded];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [HTColor ht_emptyColor];
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    SDCycleScrollView *scorllImages = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    scorllImages.autoScroll = NO;
    scorllImages.hidden = YES;
    scorllImages.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.scorllImages = scorllImages;
    [self addSubview:scorllImages];
    
    HTPOIDetailInfoSubView * subView = [HTPOIDetailInfoSubView ht_viewFromXib];
    [self addSubview:subView];
    self.subView = subView;
    
    [self ht_bottomLineShow];
    
    [scorllImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(IphoneWidth*9/16);
    }];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(170);
    }];
}



@end
