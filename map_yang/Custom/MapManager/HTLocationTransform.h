//
//  HTLocationTransform.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/12/11.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTLocationTransform : NSObject

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

- (id)initWithLatitude:(double)latitude andLongitude:(double)longitude;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coor;

/*
 坐标系：
 WGS-84：是国际标准，GPS坐标（Google Earth使用、或者GPS模块）
 GCJ-02：中国坐标偏移标准，Google Map、高德、腾讯使用
 BD-09 ：百度坐标偏移标准，Baidu Map使用
 */

#pragma mark - 从GPS坐标转化到高德坐标
- (CLLocationCoordinate2D)transformFromGPSToGD;

#pragma mark - 从高德坐标转化到百度坐标
- (CLLocationCoordinate2D)transformFromGDToBD;

#pragma mark - 从百度坐标到高德坐标
- (CLLocationCoordinate2D)transformFromBDToGD;

#pragma mark - 从高德坐标到GPS坐标
- (CLLocationCoordinate2D)transformFromGDToGPS;

#pragma mark - 从百度坐标到GPS坐标
- (CLLocationCoordinate2D)transformFromBDToGPS;

@end
