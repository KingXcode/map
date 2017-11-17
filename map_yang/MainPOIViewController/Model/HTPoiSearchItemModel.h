//
//  HTPoiSearchItemModel.h
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Realm/Realm.h>

@interface HTPoiSearchItemModel : RLMObject

//@property NSInteger ID;

@property NSString * address;

@property NSString * city;

@property double latitude;

@property double longitude;

//poi 搜索id
@property (nonatomic, copy) NSString *uid;
///名称
@property (nonatomic, copy) NSString *name;
///区域编码
@property (nonatomic, copy) NSString *adcode;
///所属区域
@property (nonatomic, copy) NSString *district;

@end


RLM_ARRAY_TYPE(HTPoiSearchItemModel);
