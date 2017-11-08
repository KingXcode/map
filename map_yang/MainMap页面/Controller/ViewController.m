//
//  ViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/7.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Masonry.h>
#import "HTProgressHUD.h"

#import "HTMainMapInfoView.h"


@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) HTMainMapInfoView * infoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //初始化地图
    [self addMapView];
    

    //右上角的按钮
    [self addInfoView];
}

-(void)addInfoView
{
    HTMainMapInfoView *infoView = [[HTMainMapInfoView alloc]initWithFrame:CGRectZero];
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
}

/**
 初始化地图
 */
-(void)addMapView
{
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MAMapTypeStandard;
    mapView.showsCompass = NO;
    mapView.showsScale = NO;
    mapView.zoomLevel = 16;
    mapView.delegate = self;
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
    
}




#pragma -mark- mapviewdelegate
/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [HTProgressHUD showMessage:@"点击了地图" forView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
