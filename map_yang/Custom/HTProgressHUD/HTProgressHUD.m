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

@end
