//
//  UIView+HTExtension.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HTExtension)
@property (nonatomic) CGFloat ht_x;
@property (nonatomic) CGFloat ht_y;
@property (nonatomic) CGFloat ht_width;
@property (nonatomic) CGFloat ht_height;




-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated;


-(void)ht_setX:(CGFloat)ht_x            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setY:(CGFloat)ht_y            animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setWidth:(CGFloat)ht_width    animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setHeight:(CGFloat)ht_height  animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
-(void)ht_setCenter:(CGPoint)center     animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;


/**
 *  设置圆角
 */
-(void)ht_setCornerRadius:(CGFloat)radius;

/**
 设置边框
 */
-(void)ht_setBorderWidth:(CGFloat)width Color:(UIColor *)color;




/**
 *  快速根据xib创建View
 */
+ (instancetype _Nullable )ht_viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)ht_intersectsWithView:(UIView *)view;



/**
 从小变大
 */
-(void)ht_CATransform3DScaleView;
-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration;
-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration andStartScale:(CGFloat)scale;

/**
 从大变小
 */
-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration
                             andEndScale:(CGFloat)scale
                              animations:(void (^)(void))animations
                              completion:(void (^)(BOOL finished))completion;

/**
 抖动
 */
-(void)ht_shakeAnnimationCompletion:(void (^)(BOOL finished))completion;




/**
 移除全部子控件
 */
- (void)ht_removeAllSubviews;



/**
 返回这个view展示时所对应的控制器，有可能是nil。
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;



@end
NS_ASSUME_NONNULL_END
