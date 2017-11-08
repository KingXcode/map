//
//  HTMainMapInfoView.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMainMapInfoView : UIView

@property (nonatomic, copy) void(^clickedInfoBtn)(NSInteger indx);

- (instancetype)initWithTopImage:(UIImage *)topImage bottomImage:(UIImage *)bottomImage;

@end
