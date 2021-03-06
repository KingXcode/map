//
//  HTPointAnnotation.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/10.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface HTPointAnnotation : MAPointAnnotation


/*
 pointType == 0 ---- 是点击地图poi获取的点
 */
@property (nonatomic,assign) NSInteger pointType;


/**
 pointType == 0 有效
 */
@property (nonatomic,strong) AMapPOI * poi;

//是否显示callout
@property (nonatomic,assign) BOOL canShowCallout;



@end
