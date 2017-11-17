//
//  NSArray+HTTools.h
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HTTools)
/*
 *    info = @{
 *             @"":[NSNumber numberWithBool:YES],
 *              ...
 *            };
 *    info    排序模型数组的相关信息
 *            key越靠前 优先级越高
 *            key    -----  为model中可以用来排序的属性    如果key是字符串等其它类型可以使用keypath的方式,如.integerValue等形式作为该字典的key
 *            value  -----  为该属性的排序方式  yes:升序   no:降序
 *
 *    ..如果该数组内的元素是可以进行排序的,那你他妈就不要用这个方法啊,系统提供了那么多排序方法   ---  有没有感受到我深深的恶意...
 *    ..如果该数组内的元素是可以进行排序的,这个方法也可以实现 用后面的字典 ---  @{@"self":[NSNumber numberWithBool:YES]}
 *    return  排序后的新数组
 */
-(NSArray *)ht_SortModelArrarInfo:(NSDictionary *)info;





/**
 反序数组
 @return 反序后的新数组
 */
-(NSArray *)ht_reverse;


/**
 去除重复的元素
 
 @param object 需要去除重复元素的数组
 @return 已经去除重复元素的新数组
 */
-(NSArray *)ht_removeRepeatRows;





/**
 根据modelArray中的属性 去除重复的元素
 目前我的测试中 NSString 和 int类型是没有问题的,过滤正常.
 感慨一下,系统的数组提供的过滤器,排序方式真的很强大
 
 @param object 模型数组
 @param keypath 模型数组元素中的一个属性
 @return 过滤之后的新数组
 */
-(NSArray *)ht_removeRepeatRowsWithKeypath:(NSString *)keypath;



/**
 将模型数组中的模型 根据keypath 获取到值与text对比 ，如果相同 则将该元素移除掉
 
 @param keypath 模型数据路径 对应的值也必须是string 否则也会返回原数组
 @param text 模型数据路径的数据 必须是string 否则返回原数组
 @return 移除包含text的模型数组
 */
-(NSMutableArray *)ht_removeItemsWithKeypath:(NSString *)keypath ByContains:(NSString *)text;
@end
