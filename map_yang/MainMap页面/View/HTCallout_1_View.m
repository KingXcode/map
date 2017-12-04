//
//  HTCallout_1_View.m
//  map_yang
//
//  Created by niesiyang on 2017/11/21.
//  Copyright © 2017年 niesiyang. All rights reserved.
//
/*
 AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
 request.location       = [AMapGeoPoint locationWithLatitude:self.poi.location.latitude longitude:self.poi.location.longitude];
 request.sortrule            = 0;
 request.requireExtension    = YES;
 request.requireSubPOIs      = YES;
 request.page                = self.page;
 [self.searchApi AMapPOIAroundSearch:request];
 [HTProgressHUD LoadingShowMessage:self.poi.name andDetailMessage:@"正在搜索中..." forView:self.view clickedCancel:nil];
 */
#import "HTCallout_1_View.h"

@interface HTCallout_1_View()
@property (weak, nonatomic) IBOutlet UIButton *arriveBtn;
@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel  *typeLabel;

    
@end

@implementation HTCallout_1_View
    
-(void)setAnnotation:(HTPointAnnotation *)annotation
{
    _annotation = annotation;
    if ([_annotation.poi isKindOfClass:[AMapPOI class]]) {
        self.titleLabel.text = _annotation.poi.name;
        self.typeLabel.text  = _annotation.poi.type;
    }
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
    __weak typeof(self) __self = self;
    [self.typeLabel addClickBlock:^(id obj) {
        [__self clickedTypeLabel];
    }];
}

-(void)clickedTypeLabel
{
    __weak typeof(self) __self = self;
    NSString *type = self.typeLabel.text;
    NSArray *typeArray = [type componentsSeparatedByString:@";"];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择类型" message:@"搜索周边建筑" preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSString *subType in typeArray) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:subType style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (__self.selectType) {
                __self.selectType(subType);
            }
        }];
        [alert addAction:action];
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];

    [[HTTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
    

}




@end
