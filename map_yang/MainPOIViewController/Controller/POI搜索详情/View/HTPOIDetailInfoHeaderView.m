//
//  HTPOIDetailInfoHeaderView.m
//  map_yang
//
//  Created by niesiyang on 2017/11/19.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIDetailInfoHeaderView.h"

@interface HTPOIDetailInfoHeaderView()

@end

@implementation HTPOIDetailInfoHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [HTColor ht_emptyColor];
    }
    return self;
}

-(void)configData:(AMapPOI *)poi
{
    _poi = poi;
    
    
}

@end
