//
//  HTPOIDetailInfoSubView.m
//  map_yang
//
//  Created by niesiyang on 2017/11/19.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIDetailInfoSubView.h"

@interface HTPOIDetailInfoSubView()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *bg_lineView;
@end

@implementation HTPOIDetailInfoSubView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    for (UIView *view in _bg_lineView) {
        [view ht_setBottomLine];
    }
    
}

@end
