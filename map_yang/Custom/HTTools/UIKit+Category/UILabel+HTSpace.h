//
//  UILabel+HTSpace.h
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HTSpace)


#pragma -mark- 这三个方法只针对label设置的text,且不能同时生效
/**
 *  改变行间距
 */
- (void)ht_label_changeLineSpace:(float)space;
/**
 *  改变字间距
 */
- (void)ht_label_changeWordSpace:(float)space;
/**
 *  改变行间距和字间距
 */
- (void)ht_label_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;




- (void)ht_label_attr_changeLineSpace:(float)space;
- (void)ht_label_attr_changeWordSpace:(float)space;
- (void)ht_label_attr_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
