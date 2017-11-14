//
//  HTPoiSearchItemModel.m
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPoiSearchItemModel.h"

@implementation HTPoiSearchItemModel

+ (NSString *)primaryKey {
    return @"ID";
}

//设置索引,可以加快检索的速度
+ (NSArray *)indexedProperties {
    return @[@"ID"];
}

+ (NSArray *)requiredProperties {
    return @[@"name"];
}

@end
