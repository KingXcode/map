//
//  HTSettingManager.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/11.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTSettingManager.h"

@implementation HTSettingManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNumber *set_screenCandela = [[NSUserDefaults standardUserDefaults]objectForKey:Setting_ScreenCandela];
        _set_screenCandela = set_screenCandela.boolValue;
        
        NSNumber *set_rotateEnabled = [[NSUserDefaults standardUserDefaults]objectForKey:Setting_RotateEnabled];
        _set_rotateEnabled = set_rotateEnabled.boolValue;
        
        NSNumber *set_rotateCameraEnabled = [[NSUserDefaults standardUserDefaults]objectForKey:Setting_RotateCameraEnabled];
        _set_rotateCameraEnabled = set_rotateCameraEnabled.boolValue;
        
        NSNumber *set_usualAddress = [[NSUserDefaults standardUserDefaults]objectForKey:Setting_UsualAddress];
        _set_usualAddress = set_usualAddress.boolValue;
        
        NSNumber *set_recommendAddress = [[NSUserDefaults standardUserDefaults]objectForKey:Setting_RecommendAddress];
        _set_recommendAddress = set_recommendAddress.boolValue;
    }
    return self;
}

-(void)setSet_screenCandela:(BOOL)set_screenCandela
{
    _set_screenCandela = set_screenCandela;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:set_screenCandela] forKey:Setting_ScreenCandela];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[UIApplication sharedApplication] setIdleTimerDisabled:_set_screenCandela];
}

-(void)setSet_rotateEnabled:(BOOL)set_rotateEnabled
{
    _set_rotateEnabled = set_rotateEnabled;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:set_rotateEnabled] forKey:Setting_RotateEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [HTMapManager sharedManager].mapView.rotateEnabled = [HTSettingManager sharedManager].set_rotateEnabled;
}

-(void)setSet_rotateCameraEnabled:(BOOL)set_rotateCameraEnabled
{
    _set_rotateCameraEnabled = set_rotateCameraEnabled;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:set_rotateCameraEnabled] forKey:Setting_RotateCameraEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [HTMapManager sharedManager].mapView.rotateCameraEnabled = [HTSettingManager sharedManager].set_rotateCameraEnabled;
}

-(void)setSet_usualAddress:(BOOL)set_usualAddress
{
    _set_usualAddress = set_usualAddress;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:set_usualAddress] forKey:Setting_UsualAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setSet_recommendAddress:(BOOL)set_recommendAddress
{
    _set_recommendAddress = set_recommendAddress;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:set_recommendAddress] forKey:Setting_RecommendAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma -mark- 单例创建
+(void)load
{
    [self initUserDefaults];
    [HTSettingManager sharedManager];
}


+(void)initUserDefaults
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Setting_ScreenCandela] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:Setting_ScreenCandela];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Setting_RotateEnabled] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:Setting_RotateEnabled];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Setting_RotateCameraEnabled] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:Setting_RotateCameraEnabled];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Setting_UsualAddress] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:Setting_UsualAddress];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Setting_RecommendAddress] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:Setting_RecommendAddress];
    }
}


static HTSettingManager *_instance;

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

@end
