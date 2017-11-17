//
//  UIView+HTBorderLine.h
//  pangu
//
//  Created by King on 2017/8/7.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>



struct HTMargins {
    CGFloat left;
    CGFloat right;
};
typedef struct HTMargins HTMargins;

CG_INLINE HTMargins
HTMarginsMake(CGFloat left, CGFloat right)
{
    HTMargins p; p.left = left; p.right = right; return p;
}

/**
 暂时只做了顶部和底部的线  其它的线要用的时候再写
 */
@interface UIView (HTBorderLine)

/**
 设置view的底部阴影
 与ht_setTopShadow 方法互斥 时间比较急以后有时间再改这里
 */
-(void)ht_setBottomShadow;
/**
 设置view的顶部阴影
 */
-(void)ht_setTopShadow;


/**
 左下设置阴影
 */
-(void)ht_setLeftAndBottomShadow;


-(void)ht_setTopLine;
-(void)ht_hiddenTopLine;
-(void)ht_setTopLeftAndRightMargins:(HTMargins)point;


/**
 显示隐藏底部现款线
 */
-(void)ht_setBottomLine;
-(void)ht_hiddenBottomLine;
/**
 设置底部线的左右边距
 */
-(void)ht_setLeftAndRightMargins:(HTMargins)point;
-(void)ht_updateBottomLineHeight:(CGFloat)height;
-(void)ht_updateBottomLineColor:(UIColor *)color;



/**
 显示隐藏右侧现款线
 */
-(void)ht_setRightLine;
-(void)ht_hiddenRightLine;
-(void)ht_setTopAndBottomMargins:(HTMargins)point;


//设置虚线
-(void)ht_creatDashedLayerSize:(CGSize)size;
@end
