//
//  HTTools+Model.h
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTTools.h"


/**
 这些个方法  我感觉不如MJExtension
 */
@interface HTTools (Model)
/**
 转json字符串
 */
+ (NSString *)ht_DataToJsonString:(id)info;
/**
 转字典
 */
+ (NSDictionary *)ht_dictionaryWithJsonString:(NSString *)jsonString;
@end
