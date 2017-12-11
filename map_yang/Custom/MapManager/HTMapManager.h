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

- (NSArray *)getInstalledMapApp;
- (void)clickedCalloutArriveSelectType:(void(^)(NSInteger type))block;

/**
 获取调用高德地图的url
 
 @param startLocation 起点经纬度坐标，
 格式为: position=lon,lat[,name]
 必选参数
 
 @param endLocation 终点经纬度坐标，
 格式为: position=lon,lat[,name]
 必选参数
 
 @param modeWay           缺省mode=car；   0
 出行方式：
 驾车:mode=car      0
 公交:mode=bus      1
 步行:mode=walk     2
 骑行:mode=ride     3
 可选参数
 
 @param policyStrategy    缺省policy=0
 当mode=car(驾车):
 0:推荐策略,
 1:避免拥堵,
 2:避免收费,
 3:不走高速（仅限移动端）
 当mode=bus(公交):
 0:最佳路线,
 1:换乘少,
 2:步行少,
 3:不坐地铁
 可选参数
 
 @return 返回调用高德APP的url
 */
-(NSString *)getAmapNaviUrlWithStartLocation:(CLLocationCoordinate2D)startLocation
                                   startName:(NSString *)startName
                                 endLocation:(CLLocationCoordinate2D)endLocation
                                     endName:(NSString *)endName
                                        mode:(NSInteger)modeWay
                                      policy:(NSInteger)policyStrategy;


- (void)openAppleMapWithStartLocation:(CLLocationCoordinate2D)startLocation
                            startName:(NSString *)startName
                          endLocation:(CLLocationCoordinate2D)endLocation
                              endName:(NSString *)endName;

@end
