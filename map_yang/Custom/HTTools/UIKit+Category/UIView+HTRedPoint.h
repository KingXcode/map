//
//  UIView+HTRedPoint.h
//  pangu
//
//  Created by King on 2017/7/12.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HTRedPoint)



/**
 设置红点数

 @param num 数字
 */
-(void)ht_setRedNumber:(NSString *)num;


/**
 最大值和最小值
 半开半闭区间  example: (0,99]
 @param minNumber 显示的最小值  默认:0
 @param maxNumber 显示的最大值  默认:99
 */
-(void)ht_redPointAutomaticHiddenByMinLimit:(NSInteger)minNumber MaxLimit:(NSInteger)maxNumber;


/**
 更新尺寸

 @param size 更新后的尺寸
 */
-(void)ht_updateRedPointSize:(CGSize)size;


/**
 相对于右上角的偏移量
 */
-(void)ht_updateRedPointOriginOffset:(CGPoint)offset;


/**
 是否只是显示一个点

 @param isShow yes：显示点；
                          no :  还原
 */
-(void)ht_showMinRedPoint:(BOOL)isShow;

@end
