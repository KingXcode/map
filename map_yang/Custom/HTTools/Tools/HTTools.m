//
//  HTTools.m
//  pangu
//
//  Created by niesiyang on 2017/2/27.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "HTTools.h"













@interface HTTools()
#pragma -mark- 还未开放的接口

@end


#pragma -mark-  这里是分割线--------------------
@implementation HTTools



//获取未读消息数量 --客户询问小红点
+(NSInteger)getUnreadCustomChatNum
{
    NSInteger unreadNum = 0;
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    for (EMConversation *conversation in conversations) {
        if ([conversation.conversationId rangeOfString:@"pg_user"].location != NSNotFound || ([conversation.conversationId rangeOfString:@"pg_third"].location != NSNotFound)) {
            unreadNum = unreadNum + conversation.unreadMessagesCount;
        }
    }
    return unreadNum;
}




+(NSUInteger)ht_getRandomNumber:(NSUInteger)from to:(NSUInteger)to
{
    return (NSUInteger)(from + (arc4random() % (to - from + 1)));
}


+ (BOOL)ht_navigation:(UINavigationController *)navigation jumpToViewControllerForString:(NSString *)ClassVc
{
    for (UIViewController *temp in navigation.viewControllers) {
        if ([temp isKindOfClass:NSClassFromString(ClassVc)]) {
            [navigation popToViewController:temp animated:YES];
            return YES;
        }
    }
    return NO;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}


@end









