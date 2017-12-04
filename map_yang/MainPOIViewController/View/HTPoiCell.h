//
//  HTPoiCell.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/12/4.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPoiCell : UITableViewCell

-(void)configModel:(AMapPOI *)poi andIndexPath:(NSIndexPath *)indexPath;

@end
