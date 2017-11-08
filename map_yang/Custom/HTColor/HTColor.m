//
//  HTColor.m
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTColor.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]


@interface HTColor()

@end

@implementation HTColor

+(UIColor *)textColor_333333
{
    return UIColorFromHex(0x333333);
}

+(UIColor *)textColor_666666
{
    return UIColorFromHex(0x666666);
}

+(UIColor *)textColor_999999
{
    return UIColorFromHex(0x999999);
}

+(UIColor *)ht_whiteColor;
{
    return [UIColor whiteColor];
}

+(UIColor *)ht_lineColor
{
    return UIColorFromHex(0xe1e1e1);
}

+(UIColor *)ht_clearColor
{
    return [UIColor clearColor];
}

+(UIColor *)ht_emptyColor
{
    return UIColorFromHex(0xf5f5f5);
}

@end
