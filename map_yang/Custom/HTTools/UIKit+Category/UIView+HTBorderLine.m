//
//  UIView+HTBorderLine.m
//  pangu
//
//  Created by King on 2017/8/7.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIView+HTBorderLine.h"

static const void *HTViewTopLine = &HTViewTopLine;
static const void *HTViewBottomLine = &HTViewBottomLine;
static const void *HTViewRightLine = &HTViewRightLine;


@interface UIView()

@property (nonatomic,strong)UIView *topLine;

@property (nonatomic,strong)UIView *bottomLine;

@property (nonatomic,strong)UIView *rightLine;


@end

@implementation UIView (HTBorderLine)




/**
 设置view的底部阴影
 */
-(void)ht_setBottomShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
}

/**
 设置view的顶部阴影
 */
-(void)ht_setTopShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,-1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
}

/**
 左下设置阴影
 */
-(void)ht_setLeftAndBottomShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(-1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
}




-(UIView *)topLine
{
    UIView *topLine = objc_getAssociatedObject(self, HTViewTopLine);
    if (topLine == nil) {
        topLine = [UIView new];
        topLine.backgroundColor = UIColorFromHex(0xe1e1e1);
        [self addSubview:topLine];
        topLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewTopLine, topLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return topLine;
}


-(void)ht_setTopLine
{
    self.topLine.hidden = NO;
}

-(void)ht_hiddenTopLine
{
    self.topLine.hidden = YES;
}

-(void)ht_setTopLeftAndRightMargins:(HTMargins)point
{
    
    [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(point.left);
        make.right.equalTo(self).mas_offset(point.right);
    }];
    [self layoutIfNeeded];
}







-(UIView *)bottomLine
{
    UIView *bottomLine = objc_getAssociatedObject(self, HTViewBottomLine);
    if (bottomLine == nil) {
        bottomLine = [UIView new];
        bottomLine.backgroundColor = UIColorFromHex(0xe1e1e1);
        [self addSubview:bottomLine];
        bottomLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewBottomLine, bottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return bottomLine;
}


-(void)ht_setBottomLine
{
    self.bottomLine.hidden = NO;
}

-(void)ht_hiddenBottomLine
{
    self.bottomLine.hidden = YES;
}

-(void)ht_setLeftAndRightMargins:(HTMargins)point
{
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(point.left);
        make.right.equalTo(self).mas_offset(point.right);
    }];
}


-(void)ht_updateBottomLineHeight:(CGFloat)height
{
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self layoutIfNeeded];
}

-(void)ht_updateBottomLineColor:(UIColor *)color
{
    self.bottomLine.backgroundColor =color;
}




-(UIView *)rightLine
{
    UIView *rightLine = objc_getAssociatedObject(self, HTViewBottomLine);
    if (rightLine == nil) {
        rightLine = [UIView new];
        rightLine.backgroundColor = UIColorFromHex(0xe1e1e1);
        [self addSubview:rightLine];
        rightLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewRightLine, rightLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(0.5);
        }];
    }
    return rightLine;
}


-(void)ht_setRightLine
{
    self.rightLine.hidden = NO;
}

-(void)ht_hiddenRightLine
{
    self.rightLine.hidden = YES;
}

-(void)ht_setTopAndBottomMargins:(HTMargins)point
{
    [self.rightLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(point.left);
        make.bottom.equalTo(self).mas_offset(-point.right);
    }];
    [self layoutIfNeeded];
}





//设置虚线
-(void)ht_creatDashedLayerSize:(CGSize)size
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [HTColor ht_lineColor].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)].CGPath;
    border.frame = CGRectMake(0, 0, size.width, size.height);
    border.lineWidth = .5f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
}




@end
