//
//  UIView+HTExtension.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "UIView+HTExtension.h"

typedef NS_ENUM(NSInteger, EdgeType) {
    TopBorder = 10000,
    LeftBorder = 20000,
    BottomBorder = 30000,
    RightBorder = 40000
};


@implementation UIView (HTExtension)
-(CGFloat)ht_x
{
    CGRect frame = self.frame;
    return frame.origin.x;
}

-(void)setHt_x:(CGFloat)ht_x
{
    CGRect frame = self.frame;
    frame.origin.x = ht_x;
    self.frame = frame;
}
-(CGFloat)ht_y
{
    CGRect frame = self.frame;
    return frame.origin.y;
}
-(void)setHt_y:(CGFloat)ht_y
{
    CGRect frame = self.frame;
    frame.origin.y = ht_y;
    self.frame = frame;
}
-(CGFloat)ht_width
{
    CGRect frame = self.frame;
    return frame.size.width;
}
-(void)setHt_width:(CGFloat)ht_width
{
    CGRect frame = self.frame;
    frame.size.width = ht_width;
    self.frame = frame;
}
-(CGFloat)ht_height
{
    CGRect frame = self.frame;
    return frame.size.height;
}
-(void)setHt_height:(CGFloat)ht_height
{
    CGRect frame = self.frame;
    frame.size.height = ht_height;
    self.frame = frame;
}
/*******************************************************************************/


/*******************************************************************************/
-(void)ht_setX:(CGFloat)ht_x animated:(BOOL)animated
{
    [self ht_setX:ht_x animated:animated completion:nil];
}
-(void)ht_setY:(CGFloat)ht_y animated:(BOOL)animated
{
    [self ht_setY:ht_y animated:animated completion:nil];
}
-(void)ht_setWidth:(CGFloat)ht_width animated:(BOOL)animated
{
    [self ht_setWidth:ht_width animated:animated completion:nil];
}
-(void)ht_setHeight:(CGFloat)ht_height animated:(BOOL)animated
{
    [self ht_setHeight:ht_height animated:animated completion:nil];
}
-(void)ht_setCenter:(CGPoint)center animated:(BOOL)animated
{
    [self ht_setCenter:center animated:animated completion:nil];
}
/*******************************************************************************/

-(void)ht_setX:(CGFloat)ht_x animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        
        [UIView animateWithDuration:0.3 animations:^{[self setHt_x:ht_x];}completion:completion];
        
    }else
    {
        [self setHt_x:ht_x];
        completion(YES);
    }
}

-(void)ht_setY:(CGFloat)ht_y animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_y:ht_y];}completion:completion];
    }else
    {
        [self setHt_y:ht_y];
        completion(YES);
    }
    
}

-(void)ht_setWidth:(CGFloat)ht_width animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_width:ht_width];}completion:completion];
    }else
    {
        [self setHt_width:ht_width];
        completion(YES);
    }
}

-(void)ht_setHeight:(CGFloat)ht_height animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setHt_height:ht_height];}completion:completion];
    }else
    {
        [self setHt_height:ht_height];
        completion(YES);
    }
}

-(void)ht_setCenter:(CGPoint)center animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{[self setCenter:center];}completion:completion];
    }else
    {
        [self setCenter:center];
    }
}



-(void)ht_setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    
}

-(void)ht_setBorderWidth:(CGFloat)width Color:(UIColor *)color
{
    if (width>0) {
        self.layer.borderWidth = width;
    }
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}


+ (instancetype)ht_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


- (BOOL)ht_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
    
}

/**
 从小变大
 */
-(void)ht_CATransform3DScaleView
{
    [self ht_CATransform3DScaleViewDuration:0.4f];
}

-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration
{
    [self ht_CATransform3DScaleViewDuration:duration andStartScale:0.1];
}

-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration andStartScale:(CGFloat)scale
{
    if (scale>1)
    {
        scale = 1;
    }
    else if (scale<=0)
    {
        scale = 0.01;
    }
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, scale, scale, 1);
    self.layer.transform = transform;
    
    [UIView animateWithDuration:duration animations:^{
        self.layer.transform = CATransform3DIdentity;
        self.layer.opacity = 1;
    }];
}


/**
 从大变小
 */
-(void)ht_CATransform3DScaleViewDuration:(NSTimeInterval)duration
                             andEndScale:(CGFloat)scale
                              animations:(void (^)(void))animations
                              completion:(void (^ )(BOOL finished))completion
{
    if (scale>1)
    {
        scale = 1;
    }
    else if (scale<=0)
    {
        scale = 0.01;
    }
    
    [UIView animateWithDuration:duration animations:^{
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DScale(transform, scale, scale, 1);
        self.layer.transform = transform;
        self.layer.opacity = 1;
        if (animations) {
            animations();
        }
    }completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}




-(void)ht_shakeAnnimationCompletion:(void (^)(BOOL finished))completion
{
    CATransform3D tran = self.layer.transform;
    [UIView animateWithDuration:0.025f animations:^{
        
        self.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
        
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.05f animations:^{
            
            self.layer.transform = CATransform3DTranslate(tran, -5, 0.0, 0.0);
            
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.05f animations:^{
                
                self.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
                
            }completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.05f animations:^{
                    
                    self.layer.transform = CATransform3DTranslate(tran, -5, 0.0, 0.0);
                    
                }completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.05f animations:^{
                        
                        self.layer.transform = CATransform3DTranslate(tran, 5, 0.0, 0.0);
                        
                    }completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.025f animations:^{
                            
                            self.layer.transform = CATransform3DIdentity;
                            
                        } completion:^(BOOL finished) {
                            if (completion) {
                                completion(finished);
                            }
                        }];
                        
                    }];
                }];
                
            }];
            
        }];
        
    }];
    
}




/**
 移除全部子控件
 */
- (void)ht_removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


/**
 返回这个view展示时所对应的控制器，有可能是nil。
 */
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
