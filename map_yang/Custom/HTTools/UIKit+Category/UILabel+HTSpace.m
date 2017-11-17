//
//  UILabel+HTSpace.m
//  pangu
//
//  Created by King on 2017/6/16.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UILabel+HTSpace.h"
#import <CoreText/CoreText.h>

@implementation UILabel (HTSpace)
- (void)ht_label_changeLineSpace:(float)space
{
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)ht_label_changeWordSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    
    [self sizeToFit];
    
}

- (void)ht_label_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}










- (void)ht_label_attr_changeLineSpace:(float)space
{
    if (self.attributedText.length>0)
    {
        NSAttributedString *labelText = self.attributedText;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
    else
    {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }

    
}

- (void)ht_label_attr_changeWordSpace:(float)space {
    
    if (self.attributedText.length>0)
    {
        NSAttributedString *labelText = self.attributedText;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:labelText];
        
        [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(space) range:NSMakeRange(0, [attributedString length])];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        
        [self sizeToFit];

    }
    else
    {
        NSString *labelText = self.text;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        
        [self sizeToFit];
    }

    
}

- (void)ht_label_attr_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace
{
    
    if (self.attributedText.length>0)
    {
        NSAttributedString *labelText = self.attributedText;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:labelText];
        
        [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [attributedString length])];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:lineSpace];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        
        self.attributedText = attributedString;
        
        [self sizeToFit];
    }
    else
    {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}





/**
 *  计算label字体高度
 *
 *  @param lineSpeace 行间距
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return label高度
 */
-(CGFloat)ht_getSpaceLabelHeightwithSpace:(CGFloat)lineSpace
                                withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    /** 行高 */
    paraStyle.lineSpacing = lineSpace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{
                          NSFontAttributeName:self.font,
                          NSParagraphStyleAttributeName:paraStyle,
                          };
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dic
                                          context:nil].size;
    return size.height;
}




@end
