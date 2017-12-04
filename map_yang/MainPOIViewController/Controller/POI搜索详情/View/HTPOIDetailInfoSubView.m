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
        [view ht_bottomLineShow];
    }
    __weak typeof(self) __self = self;
    [self.telLabel addClickBlock:^(id obj) {
        NSString *tel = __self.telLabel.text;
        if ([tel isEqualToString:@"---"]) {
            return ;
        }
        
        NSArray *telArray = [tel componentsSeparatedByString:@";"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSString *subTel in telArray) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:subTel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [HTTools ht_callPhone:subTel];
            }];
            [alert addAction:action];
        }
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [[HTTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }];
    
    [self.websiteLabel addClickBlock:^(id obj) {
        NSString *url = __self.websiteLabel.text;
        if(![url hasPrefix:@"http"])
        {
            url = [NSString stringWithFormat:@"http://%@",url];
        }
        if ([HTTools ht_IsUrl:url]) {
            [HTTools openSafariServiceWithUrl:[NSURL URLWithString:url] byController:[HTTools getCurrentVC]];
        }
    }];
    
    
}

@end
