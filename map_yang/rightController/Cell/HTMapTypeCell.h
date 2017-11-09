//
//  HTMapTypeCell.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/9.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMapTypeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,assign) BOOL isSelect;

@end
