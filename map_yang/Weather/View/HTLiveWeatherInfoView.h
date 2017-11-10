//
//  HTLiveWeatherInfoView.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/10.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface HTLiveWeatherInfoView : UIView

//创建方法
+ (instancetype)loadView;

//天气数据
@property (nonatomic,strong,readonly) AMapLocalWeatherLive * liveWeather;

//更新数据
-(void)updateLiveWeather:(AMapLocalWeatherLive *)liveWeather;

//显示天气标签
-(void)showWeatherView;
//隐藏天气标签
-(void)hiddenWeatherView;


@end
