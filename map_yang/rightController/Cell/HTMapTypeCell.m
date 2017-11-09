//
//  HTMapTypeCell.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/9.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMapTypeCell.h"

@implementation HTMapTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 3;
    self.imageView.clipsToBounds = YES;
}

@end
