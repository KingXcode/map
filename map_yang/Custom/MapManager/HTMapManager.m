//
//  HTMapManager.m
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMapManager.h"
#import <MapKit/MapKit.h>
#import "HTLocationTransform.h"

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
- (NSArray *)getInstalledMapApp
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


-(void)clickedCalloutArriveSelectType:(void(^)(NSInteger type))block
{
    NSArray *array =  [[HTMapManager sharedManager] getInstalledMapApp];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"选择导航软件" preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSString *title in array) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([title isEqualToString:@"苹果地图"])
            {
                if (block) {
                    block(1);
                }
            }
//            else if ([title isEqualToString:@"百度地图"])
//            {
//                if (block) {
//                    block(2);
//                }
//            }
            else if ([title isEqualToString:@"高德地图"])
            {
                if (block) {
                    block(3);
                }
                
            }
//            else if ([title isEqualToString:@"腾讯地图"])
//            {
//                if (block) {
//                    block(4);
//                }
//            }
        }];
        [alert addAction:action];
    }
    [[HTTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
}


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
                                      policy:(NSInteger)policyStrategy
{
    NSMutableString *url = [NSMutableString stringWithFormat:@"http://uri.amap.com/navigation?"];
    if ([HTTools ht_isBlankString:startName]||startName.length<1) {
        startName = @"我的位置";
    }
    if ([HTTools ht_isBlankString:endName]||endName.length<1) {
        endName = @"终点";
    }
    NSString *from = [NSString stringWithFormat:@"from=%f,%f,%@&",startLocation.longitude,startLocation.latitude,startName];
    NSString *to = [NSString stringWithFormat:@"to=%f,%f,%@&",endLocation.longitude,endLocation.latitude,endName];
    NSString *model;
    switch (modeWay) {
        case 0:
            model = @"mode=car&";
            break;
        case 1:
            model = @"mode=bus&";
            break;
        case 2:
            model = @"mode=walk&";
            break;
        case 3:
            model = @"mode=ride&";
            break;
        default:
            model = @"mode=car&";
            break;
    }
    NSString *policy = [NSString stringWithFormat:@"policy=%zd&",policyStrategy];
    [url appendString:from];
    [url appendString:to];
    [url appendString:model];
    [url appendString:policy];
    [url appendFormat:@"coordinate=gaode&callnative=1"];
    NSCharacterSet *character = [NSCharacterSet URLFragmentAllowedCharacterSet];
    return [url stringByAddingPercentEncodingWithAllowedCharacters:character];
}


- (void)openAppleMapWithStartLocation:(CLLocationCoordinate2D)startLocation
                            startName:(NSString *)startName
                         endLocation:(CLLocationCoordinate2D)endLocation
                              endName:(NSString *)endName
{

    MKMapItem *currentLoc = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:startLocation addressDictionary:nil]];
    currentLoc.name = startName;
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endLocation addressDictionary:nil]];
    toLocation.name = endName;
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}




@end
