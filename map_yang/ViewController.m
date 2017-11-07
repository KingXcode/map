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


@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic,weak)MAMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MAMapTypeStandard;
    mapView.showsCompass = NO;
    mapView.showsScale = NO;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view).mas_offset(self.view.safeAreaInsets);
        } else {
            make.edges.equalTo(self.view);
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
