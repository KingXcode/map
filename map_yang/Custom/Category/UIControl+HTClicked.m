//
//  UIControl+HTSound.m
//  pangu
//
//  Created by King on 2017/6/15.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIControl+HTClicked.h"
#import <objc/runtime.h>


@implementation UIControl (HTClicked)






#define HT_UICONTROL_EVENT(methodName, eventName)                                \
-(void)methodName : (void (^)(void))eventBlock {                              \
objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
[self addTarget:self                                                        \
action:@selector(methodName##Action:)                                       \
forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
-(void)methodName##Action:(id)sender {                                        \
void (^block)() = objc_getAssociatedObject(self, @selector(methodName:));  \
if (block) {                                                                \
block();                                                                \
}                                                                           \
}

HT_UICONTROL_EVENT(ht_touchDown, TouchDown)
HT_UICONTROL_EVENT(ht_touchDownRepeat, TouchDownRepeat)
HT_UICONTROL_EVENT(ht_touchDragInside, TouchDragInside)
HT_UICONTROL_EVENT(ht_touchDragOutside, TouchDragOutside)
HT_UICONTROL_EVENT(ht_touchDragEnter, TouchDragEnter)
HT_UICONTROL_EVENT(ht_touchDragExit, TouchDragExit)
HT_UICONTROL_EVENT(ht_touchUpInside, TouchUpInside)
HT_UICONTROL_EVENT(ht_touchUpOutside, TouchUpOutside)
HT_UICONTROL_EVENT(ht_touchCancel, TouchCancel)
HT_UICONTROL_EVENT(ht_valueChanged, ValueChanged)
HT_UICONTROL_EVENT(ht_editingDidBegin, EditingDidBegin)
HT_UICONTROL_EVENT(ht_editingChanged, EditingChanged)
HT_UICONTROL_EVENT(ht_editingDidEnd, EditingDidEnd)
HT_UICONTROL_EVENT(ht_editingDidEndOnExit, EditingDidEndOnExit)









@end
