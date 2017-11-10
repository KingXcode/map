//
//  ViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//  default_icon_c5_normal.png +
//  default_icon_c6_normal.png -

#import "ViewController.h"
#import <RESideMenu.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Masonry.h>

#import "HTProgressHUD.h"
#import "HTColor.h"
#import "HTMainMapInfoView.h"
#import "HTMapManager.h"
#import "HTPointAnnotation.h"
#import "HTLiveWeatherInfoView.h"


@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) AMapSearchAPI * search;


@property (nonatomic,strong) HTMainMapInfoView * infoView;
@property (nonatomic,strong) HTMainMapInfoView * scaleView;

@property (nonatomic,weak) HTLiveWeatherInfoView * weatherView;


//当前位置实时天气信息
@property (nonatomic,strong) AMapLocalWeatherLive * liveWeather;

//天气预报---(目前还没有请求这个数据,当前只做实时天气的view,我的想法是以后点击实时天气跳转页面来展示预报天气)
@property (nonatomic,strong) AMapLocalWeatherForecast * forecastWeather;

//点击地图poi信息 获取到的点
@property (nonatomic, strong) MAPointAnnotation *poiAnnotation;


@end

@implementation ViewController

-(AMapSearchAPI *)search
{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
    }
    return _search;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [HTColor ht_whiteColor];

    //初始化地图
    [self addMapView];

    //右上角的按钮
    [self addInfoView];
    
    //添加天气view
    [self addWeatherView];
}

-(void)addWeatherView
{
    HTLiveWeatherInfoView *weatherView = [HTLiveWeatherInfoView loadView];
    [self.view addSubview:weatherView];
    self.weatherView = weatherView;
}


-(void)addInfoView
{
    
    HTMainMapInfoView *infoView = [[HTMainMapInfoView alloc]initWithTopImage:[UIImage imageNamed:@"info"] bottomImage:[UIImage imageNamed:@"location"]];
    self.infoView = infoView;
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView).mas_offset(10);
        make.right.equalTo(self.mapView).mas_offset(-10);
        make.width.equalTo(@(44));
        make.height.equalTo(@(88));
    }];
    
    __weak typeof(self) __self = self;
    [infoView setClickedInfoBtn:^(NSInteger index) {
        if (index == 0)
        {
            [__self showInfoView];
        }
        else if (index == 1)
        {
            [__self showSelfLocation];
        }
    }];
    
    
    HTMainMapInfoView *scaleView = [[HTMainMapInfoView alloc]initWithTopImage:[UIImage imageNamed:@"add"] bottomImage:[UIImage imageNamed:@"move"]];
    self.scaleView = scaleView;
    [self.view addSubview:scaleView];
    [scaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom).mas_offset(18);
        make.right.equalTo(self.mapView).mas_offset(-10);
        make.width.equalTo(@(44));
        make.height.equalTo(@(88));
    }];
    
    [scaleView setClickedInfoBtn:^(NSInteger index) {
        if (index == 0)
        {
            [__self.mapView setZoomLevel:__self.mapView.zoomLevel+1 animated:YES];
        }
        else if (index == 1)
        {
            [__self.mapView setZoomLevel:__self.mapView.zoomLevel-1 animated:YES];
        }
        
    }];
}

/**
 初始化地图

 */
-(void)addMapView
{
    ///初始化地图
    
    MAMapView *mapView = [HTMapManager sharedManager].mapView;
    mapView.mapType = MAMapTypeStandard;
    mapView.showsCompass = NO;
    mapView.showsScale = NO;
    mapView.zoomLevel = 16;
    mapView.delegate = self;
    mapView.touchPOIEnabled = YES;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
    represent.showsAccuracyRing = YES;
    represent.showsHeadingIndicator = YES;
    represent.lineWidth = 1.f;
    [self.mapView updateUserLocationRepresentation:represent];
    
    
    
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view).mas_offset(self.view.safeAreaInsets.top+[[UIApplication sharedApplication] statusBarFrame].size.height);
            make.left.equalTo(self.view).mas_offset(self.view.safeAreaInsets.left);
            make.right.equalTo(self.view).mas_offset(self.view.safeAreaInsets.right);
            make.bottom.equalTo(self.view).mas_offset(self.view.safeAreaInsets.bottom);
        } else {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}




//获取当前城市逆编码信息
- (void)searchLocationReGeoCode
{
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.mapView.userLocation.location.coordinate.latitude longitude:self.mapView.userLocation.location.coordinate.longitude];
    [self.search AMapReGoecodeSearch:request];
}



#pragma -mark- mapviewdelegate

/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {//定位成功更新
        if (self.liveWeather == nil) {
            [self searchLocationReGeoCode];
        }
    }
}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.weatherView hiddenWeatherView];
}

/**
 * @brief 地图将要发生缩放时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
{
    [mapView setShowsScale:YES];
}

/**
 * @brief 地图缩放结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{
    [mapView setShowsScale:NO];
}

/**
 * @brief 当touchPOIEnabled == YES时，单击地图使用该回调获取POI信息
 * @param mapView 地图View
 * @param pois 获取到的poi数组(由MATouchPoi组成)
 */
-(void)mapView:(MAMapView *)mapView didTouchPois:(NSArray *)pois
{
    if (pois.count>0) {
        
        MATouchPoi *touchPoi = pois.firstObject;
        HTPointAnnotation *annotation = [[HTPointAnnotation alloc] init];
        annotation.coordinate = touchPoi.coordinate;
        annotation.title      = touchPoi.name;
        annotation.pointType  = 0;
        [self.mapView removeAnnotation:self.poiAnnotation];
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
        self.poiAnnotation = annotation;
        [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];

        
        MATouchPoi *poi = pois.firstObject;
        AMapPOIIDSearchRequest *request = [[AMapPOIIDSearchRequest alloc]init];
        request.uid = poi.uid;
        [self.search AMapPOIIDSearch:request];
        
    }
}

/**
 * @brief 根据anntation生成对应的View。
 
 注意：5.1.0后由于定位蓝点增加了平滑移动功能，如果在开启定位的情况先添加annotation，需要在此回调方法中判断annotation是否为MAUserLocation，从而返回正确的View。
 if ([annotation isKindOfClass:[MAUserLocation class]]) {
 return nil;
 }
 
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[HTPointAnnotation class]])
    {
        HTPointAnnotation *anno = (HTPointAnnotation *)annotation;
        if (anno.pointType == 0)
        {
            return [self getPoiAnnotationViewWithMapView:mapView andAnnotation:anno];
        }
        else
        {
            return nil;
        }
    }
    return nil;
}

-(MAPinAnnotationView *)getPoiAnnotationViewWithMapView:(MAMapView *)mapView andAnnotation:(HTPointAnnotation *)annotation
{
    static NSString *touchPoiReuseIndetifier = @"touchPoiReuseIndetifier";
    MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:touchPoiReuseIndetifier];
    if (annotationView == nil)
    {
        annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:touchPoiReuseIndetifier];
    }
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop   = NO;
    annotationView.draggable      = NO;
    annotationView.image = [UIImage imageNamed:@"b_poi_hl"];
    annotationView.layer.anchorPoint = CGPointMake(0.5, 0.9189);
    annotationView.bounds = CGRectMake(0, 0, 44, 54);
    
    return annotationView;
}





#pragma -mark- AMapSearchAPI delegate
/**
 * @brief 当请求发生错误时，会调用代理的此方法.
 * @param request 发生错误的请求.
 * @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"--------:%@",error);
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    NSLog(@"--------:%@",response);
}

/**
 * @brief 逆地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    AMapWeatherSearchRequest *weatherrequest = [[AMapWeatherSearchRequest alloc] init];
    weatherrequest.city                      = response.regeocode.addressComponent.city;
    weatherrequest.type                      = AMapWeatherTypeLive;
    [self.search AMapWeatherSearch:weatherrequest];
}

/**
 * @brief 天气查询回调
 * @param request  发起的请求，具体字段参考 AMapWeatherSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapWeatherSearchResponse 。
 */
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
    if (request.type == AMapWeatherTypeLive)
    {
        if (response.lives.count == 0)
        {
            return;
        }
        AMapLocalWeatherLive *liveWeather = [response.lives firstObject];
        if (liveWeather != nil)
        {
            self.liveWeather = liveWeather;
            [self.weatherView updateLiveWeather:liveWeather];
        }
    }
    else
    {
        if (response.forecasts.count == 0)
        {
            return;
        }
        AMapLocalWeatherForecast *forecast = [response.forecasts firstObject];
        
        if (forecast != nil)
        {
            self.forecastWeather = forecast;
        }
    }
}




#pragma -mark- 点击事件




//显示自己的位置
-(void)showSelfLocation
{
    [self.mapView removeAnnotation:self.poiAnnotation];
    self.poiAnnotation = nil;
    [self.mapView setZoomLevel:16 animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    [self.mapView setRotationDegree:0 animated:YES duration:0.5];
}

//点击详细信息按钮
-(void)showInfoView
{
    [self.sideMenuViewController presentRightMenuViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}


@end
