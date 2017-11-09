//
//  ViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//  default_icon_c5_normal.png +
//  default_icon_c6_normal.png -

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Masonry.h>
#import "HTProgressHUD.h"
#import "HTColor.h"
#import "HTMainMapInfoView.h"
#import <RESideMenu.h>
#import "HTMapManager.h"


@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) AMapSearchAPI * search;

@property (nonatomic,strong) HTMainMapInfoView * infoView;
@property (nonatomic,strong) HTMainMapInfoView * scaleView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HTColor ht_whiteColor];

    //初始化地图
    [self addMapView];
    

    //右上角的按钮
    [self addInfoView];
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


//显示自己的位置
-(void)showSelfLocation
{
    [self.mapView setZoomLevel:16 animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    [self.mapView setRotationDegree:0 animated:YES duration:0.5];
}

//点击详细信息按钮
-(void)showInfoView
{
    [self.sideMenuViewController presentRightMenuViewController];
}




#pragma -mark- mapviewdelegate
/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{

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
        MATouchPoi *poi = pois.firstObject;
        AMapPOIIDSearchRequest *request = [[AMapPOIIDSearchRequest alloc]init];
        request.uid = poi.uid;
        [self.search AMapPOIIDSearch:request];
    }
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
