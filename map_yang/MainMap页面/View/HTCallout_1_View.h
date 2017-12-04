//
//  HTCallout_1_View.h
//  map_yang
//
//  Created by niesiyang on 2017/11/21.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPointAnnotation.h"

@interface HTCallout_1_View : UIView

+(instancetype)loadView;
    
@property (nonatomic,strong) HTPointAnnotation * annotation;


@property (nonatomic, copy) void(^arrive)();


@property (nonatomic, copy) void(^selectType)(NSString *type);

@end
