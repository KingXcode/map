//
//  HTSettingManager.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/11.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define Setting_ScreenCandela          @"屏幕常亮-设置"
#define Setting_RotateEnabled          @"旋转手势-设置"
#define Setting_RotateCameraEnabled    @"切换视角-设置"
#define Setting_UsualAddress           @"地图上显示常用地址-设置"
#define Setting_RecommendAddress       @"显示推荐的常用地址-设置"

/**
 系统设置管理类
 */
@interface HTSettingManager : NSObject

+(instancetype)sharedManager;

/**
 屏幕常亮-设置
 */
@property (nonatomic,assign) BOOL set_screenCandela;

/**
 旋转手势-设置
 */
@property (nonatomic,assign) BOOL set_rotateEnabled;

/**
 切换视角-设置
 */
@property (nonatomic,assign) BOOL set_rotateCameraEnabled;

/**
 地图上显示常用地址-设置
 */
@property (nonatomic,assign) BOOL set_usualAddress;

/**
 显示推荐的常用地址-设置
 */
@property (nonatomic,assign) BOOL set_recommendAddress;


@end
