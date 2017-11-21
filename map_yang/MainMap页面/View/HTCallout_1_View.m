//
//  HTCallout_1_View.m
//  map_yang
//
//  Created by niesiyang on 2017/11/21.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTCallout_1_View.h"

@interface HTCallout_1_View()
@property (weak, nonatomic) IBOutlet UIButton *arriveBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    
@end

@implementation HTCallout_1_View
    
-(void)setAnnotation:(HTPointAnnotation *)annotation
{
    _annotation = annotation;
    self.titleLabel.text = _annotation.poi.name;
}
    
- (IBAction)arrive:(UIButton *)sender {
    if(self.arrive)
    {
        self.arrive();
    }
}
    
+(instancetype)loadView
{
    return [self ht_viewFromXib];
}
    
-(void)awakeFromNib
{
    [super awakeFromNib];
     
    [self ht_setCornerRadius:5];
     
    [self ht_setBorderWidth:1 Color:[HTColor ht_lineColor]];
}

@end
