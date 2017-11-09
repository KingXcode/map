//
//  HTMapSelectTypeCell.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/9.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 MAMapTypeStandard = 0,  ///< 普通地图
 MAMapTypeSatellite,     ///< 卫星地图
 MAMapTypeStandardNight, ///< 夜间视图
 MAMapTypeNavi,          ///< 导航视图
 MAMapTypeBus            ///< 公交视图
 
 */

@protocol HTMapSelectTypeCellDelegate<NSObject>

-(void)didselectType:(NSInteger)type;

@end


@interface HTMapSelectTypeCell : UITableViewCell

@property (nonatomic,weak) id<HTMapSelectTypeCellDelegate> delegate;

@end
