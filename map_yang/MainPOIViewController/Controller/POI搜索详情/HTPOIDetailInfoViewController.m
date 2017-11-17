//
//  HTPOIDetailInfoViewController.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/16.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIDetailInfoViewController.h"
#import "HTMainPoiNavCtl.h"

@interface HTPOIDetailInfoViewController ()

@end

@implementation HTPOIDetailInfoViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HTMainPoiNavCtl *nav = (HTMainPoiNavCtl *)self.navigationController;
    if ([nav isKindOfClass:[HTMainPoiNavCtl class]]) {
        nav.position = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [HTColor ht_whiteColor];
    self.title = self.poi.name;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
