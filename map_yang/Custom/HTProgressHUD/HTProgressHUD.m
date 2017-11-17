//
//  HTProgressHUD.m
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTProgressHUD.h"
#import <MBProgressHUD.h>
#import "HTColor.h"

@interface HTProgressHUD()

@end

@implementation HTProgressHUD

+(void)showMessage:(NSString *)message forView:(UIView *)view
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = message;
    hub.label.textColor = [HTColor textColor_333333];
    hub.mode = MBProgressHUDModeText;
    hub.margin = 15;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hub hideAnimated:YES];
    });
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message andDetailMessage:(NSString *)detailMessage forView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = message;
    if (detailMessage) {
        hub.detailsLabel.text = detailMessage;
    }
    hub.label.textColor = [HTColor textColor_333333];
    hub.margin = 15;
    hub.mode = MBProgressHUDModeIndeterminate;
    return hub;
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message forView:(UIView *)view
{
    return [self LoadingShowMessage:message andDetailMessage:nil forView:view];
//    if (view == nil) {
//        view = [UIApplication sharedApplication].keyWindow;
//    }
//    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hub.label.text = message;
//    hub.label.textColor = [HTColor textColor_333333];
//    hub.margin = 15;
//    hub.mode = MBProgressHUDModeIndeterminate;
//    return hub;
}

+(void)HiddenForView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message
{
    return [self LoadingShowMessage:message forView:nil];
}

+(void)Hidden
{
    [self HiddenForView:nil];
}


@end
