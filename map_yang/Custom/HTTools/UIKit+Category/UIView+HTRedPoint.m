//
//  UIView+HTRedPoint.m
//  pangu
//
//  Created by King on 2017/7/12.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIView+HTRedPoint.h"
#import <objc/runtime.h>

static const void *HTRedPointLabel = &HTRedPointLabel;
static const void *HTMinNumber = &HTMinNumber;
static const void *HTMaxNumber = &HTMaxNumber;

static const void *HTSizeValue = &HTSizeValue;
static const void *HTOffsetValue = &HTOffsetValue;

@interface UIView()

@property (nonatomic,strong)UILabel *redPointLabel;
@property (nonatomic,copy)NSNumber *minNumber;
@property (nonatomic,copy)NSNumber *maxNumber;

@property (nonatomic,strong)NSValue *sizeValue;
@property (nonatomic,strong)NSValue *offsetValue;

@end

@implementation UIView (HTRedPoint)

-(void)ht_showMinRedPoint:(BOOL)isShow
{
    UILabel *redPointLabel = objc_getAssociatedObject(self, HTRedPointLabel);
    if (isShow)
    {
        NSValue *cacheValue = self.sizeValue;
        redPointLabel.textColor = [UIColor redColor];
        [self ht_updateRedPointSize:CGSizeMake(8, 8)];
        self.sizeValue = cacheValue;
    }
    else
    {
        redPointLabel.textColor = [UIColor whiteColor];
        [self ht_updateRedPointSize:self.sizeValue.CGSizeValue];
    }
}


-(void)ht_updateRedPointSize:(CGSize)size
{
    UILabel *redPointLabel = objc_getAssociatedObject(self, HTRedPointLabel);
    if (redPointLabel != nil)
    {
        [redPointLabel ht_setCornerRadius:MIN(size.height, size.width)*0.5];
        [self.redPointLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
        [self layoutIfNeeded];
    }
    self.sizeValue = [NSValue valueWithCGSize:size];
}

-(void)ht_updateRedPointOriginOffset:(CGPoint)offset
{
    UILabel *redPointLabel = objc_getAssociatedObject(self, HTRedPointLabel);
    if (redPointLabel != nil)
    {
        [self.redPointLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_right).mas_offset(offset.x);
            make.centerY.equalTo(self.mas_top).mas_offset(offset.y);
        }];
        [self layoutIfNeeded];
    }
    self.offsetValue = [NSValue valueWithCGPoint:offset];
}



-(void)ht_setRedNumber:(NSString *)num
{
    self.redPointLabel.hidden = [self checkLimitNumberByRedNumbe:num];
    if (num.floatValue>self.maxNumber.floatValue) {
        num = [NSString stringWithFormat:@"%@+",self.maxNumber];
    }
    CGSize size = [HTTools sizeOfString:num font:[UIFont systemFontOfSize:10] width:100];
    if (size.width+6>self.sizeValue.CGSizeValue.width) {
        [self.redPointLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width+6);
        }];
    }
    else
    {
        [self.redPointLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.sizeValue.CGSizeValue.width);
        }];
    }
    self.redPointLabel.text = num;
}

//当数据异常 返回yes 隐藏label
-(BOOL)checkLimitNumberByRedNumbe:(NSString *)number
{
    
    if ([HTTools ht_isBlankString:number] || [number isEqualToString:@"(null)"]) {
        return YES;
    }
    
    CGFloat redNum = number.floatValue;
    if (redNum<=self.minNumber.floatValue) {
        return YES;
    }
    return NO;
}

-(UILabel *)redPointLabel
{
    UILabel *redPointLabel = objc_getAssociatedObject(self, HTRedPointLabel);
    if (redPointLabel == nil) {
        redPointLabel = [[UILabel alloc]init];
        redPointLabel.adjustsFontSizeToFitWidth = YES;
        redPointLabel.textColor = [UIColor whiteColor];
        redPointLabel.backgroundColor = [UIColor redColor];
        redPointLabel.textAlignment = NSTextAlignmentCenter;
        redPointLabel.font = [UIFont systemFontOfSize:10];
        
        CGPoint offset = self.offsetValue.CGPointValue;
        CGSize size = self.sizeValue.CGSizeValue;
        [redPointLabel ht_setCornerRadius:MIN(size.width, size.height)*0.5];
        
        objc_setAssociatedObject(self, HTRedPointLabel, redPointLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:redPointLabel];
        
        [redPointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.sizeValue);
            make.centerX.equalTo(self.mas_right).mas_offset(offset.x);
            make.centerY.equalTo(self.mas_top).mas_offset(offset.y);
        }];
    }
    return redPointLabel;
}


-(void)ht_redPointAutomaticHiddenByMinLimit:(NSInteger)minNumber MaxLimit:(NSInteger)maxNumber
{
    self.minNumber = @(minNumber);
    self.maxNumber = @(maxNumber);
}


-(void)setMinNumber:(NSNumber *)minNumber
{
    objc_setAssociatedObject(self, HTMinNumber, minNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSNumber *)minNumber
{
    NSNumber *min = objc_getAssociatedObject(self, HTMinNumber);
    if (min == nil) {
        min = @(0);
    }
    return min ;
}



-(void)setMaxNumber:(NSNumber *)maxNumber
{
    objc_setAssociatedObject(self, HTMaxNumber, maxNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSNumber *)maxNumber
{
    NSNumber *max = objc_getAssociatedObject(self, HTMaxNumber);
    if (max == nil) {
        max = @(99);
    }
    return max;
}



-(void)setSizeValue:(NSValue *)sizeValue
{
    objc_setAssociatedObject(self, HTSizeValue, sizeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSValue *)sizeValue
{
    NSValue *size = objc_getAssociatedObject(self, HTSizeValue);
    if (size == nil) {
        size = [NSValue valueWithCGSize:CGSizeMake(18, 18)];
    }
    return size;
}

-(void)setOffsetValue:(NSValue *)offsetValue
{
    objc_setAssociatedObject(self, HTOffsetValue, offsetValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSValue *)offsetValue
{
    NSValue *offset = objc_getAssociatedObject(self, HTOffsetValue);
    if (offset == nil) {
        offset = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    }
    return offset;
}


@end
