//
//  HTMainMapInfoView.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMainMapInfoView.h"
#import <Masonry.h>
#import "HTColor.h"

@interface HTMainMapInfoView()

@end

@implementation HTMainMapInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIButton *top = [UIButton buttonWithType:UIButtonTypeCustom];
    [top setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
    top.backgroundColor = [HTColor ht_whiteColor];
    [self addSubview:top];
    
    UIButton *bottom = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottom setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    bottom.backgroundColor = [HTColor ht_whiteColor];
    [self addSubview:bottom];
    
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(bottom.mas_top).mas_offset(0.5);
        make.height.equalTo(bottom);
    }];
    
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [HTColor ht_lineColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(top.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [HTColor ht_lineColor].CGColor;
    self.clipsToBounds = YES;
    
    
    [top addTarget:self action:@selector(clickedtopBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottom addTarget:self action:@selector(clickedbottomBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickedtopBtn
{
    if (self.clickedInfoBtn) {
        self.clickedInfoBtn(0);
    }
}

-(void)clickedbottomBtn
{
    if (self.clickedInfoBtn) {
        self.clickedInfoBtn(1);
    }
}






@end
