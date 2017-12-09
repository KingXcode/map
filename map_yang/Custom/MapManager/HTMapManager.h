//
//  HTMapManager.h
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface HTMapManager : NSObject

+(instancetype)sharedManager;

@property (nonatomic,strong)MAMapView *mapView;

//当前城市
@property (nonatomic,copy) NSString * currentCity;

//搜索城市  默认是当前城市
@property (nonatomic,copy) NSString * searchCity;

@property (nonatomic,strong) MAUserLocation *userLocation;

- (NSArray *)getInstalledMapAppWithStartLocation:(CLLocationCoordinate2D)startLocation EndLocation:(CLLocationCoordinate2D)endLocation;

@end
