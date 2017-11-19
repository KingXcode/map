//
//  HTPOIDetailInfoHeaderView.h
//  map_yang
//
//  Created by niesiyang on 2017/11/19.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPOIDetailInfoHeaderView : UIView

@property (nonatomic,strong,readonly) AMapPOI * poi;

-(void)configData:(AMapPOI *)poi;

@end
