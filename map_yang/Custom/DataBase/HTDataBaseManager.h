//
//  HTDataBaseManager.h
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>


/**
 RLMRealm有个好处 这个类中几乎没什么代码,而且不需要用到sqlite代码了
 */
@interface HTDataBaseManager : NSObject

+(instancetype)sharedManager;

- (void)creatDataBaseWithName:(NSString *)databaseName;

@property (nonatomic,strong) RLMRealm * realm;

@end
