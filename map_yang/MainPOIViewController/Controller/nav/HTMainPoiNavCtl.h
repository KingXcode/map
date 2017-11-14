//
//  HTMainPoiNavCtl.h
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMainPoiNavCtl : UINavigationController

@property (nonatomic,assign) NSInteger position;

@property (nonatomic, copy) void(^showScreenPosition)(NSInteger position);

@end
