//
//  HTMapManager.m
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMapManager.h"

@interface HTMapManager()

@end

@implementation HTMapManager

#pragma -mark- 单例创建
static HTMapManager *_instance;

+(instancetype)sharedManager
{
    return [[self alloc]init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(MAMapView *)mapView
{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _mapView;
}


#pragma mark - 导航方法
- (NSArray *)getInstalledMapAppWithStartLocation:(CLLocationCoordinate2D)startLocation EndLocation:(CLLocationCoordinate2D)endLocation
{
    NSMutableArray *maps = [NSMutableArray array];
    //苹果地图
    [maps addObject:@"苹果地图"];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [maps addObject:@"百度地图"];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [maps addObject: @"高德地图"];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        [maps addObject:@"腾讯地图"];
    }
    
    return maps;
}





@end
