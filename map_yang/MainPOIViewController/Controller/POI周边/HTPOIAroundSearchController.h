//
//  HTPOIAroundSearchController.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/12/4.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPOIAroundSearchController : UIViewController

@property (nonatomic,strong,readonly) AMapPOI * poi;

-(instancetype)initWithType:(NSString *)type poi:(AMapPOI *)poi;

@end
