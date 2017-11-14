//
//  HTMainPoiNavCtl.m
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMainPoiNavCtl.h"
#import <RESideMenu.h>

@interface HTMainPoiNavCtl ()<UINavigationControllerDelegate>

@property (nonatomic,assign) CGRect topFrame;
@property (nonatomic,assign) CGRect centerFrame;
@property (nonatomic,assign) CGRect bottomFrame;
@property (nonatomic,assign) CGRect hiddenFrame;


@property (nonatomic,weak) UIImageView * swipeImage;

@end

@implementation HTMainPoiNavCtl

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _position = 2;
    
    self.view.layer.cornerRadius = 5;
    self.view.layer.borderColor = [HTColor textColor_666666].CGColor;
    self.view.layer.borderWidth = 0.5;
    self.view.clipsToBounds = YES;
    
    self.topFrame = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
    self.centerFrame = CGRectMake(4, IphoneHeight*0.5, IphoneWidth-8, IphoneHeight*0.5);
    self.bottomFrame = CGRectMake(4, IphoneHeight-(self.view.superview.safeAreaInsets.bottom + 80), IphoneWidth-8, self.view.superview.safeAreaInsets.bottom + 80);
    self.hiddenFrame = CGRectMake(4, IphoneHeight-(self.view.superview.safeAreaInsets.bottom), IphoneWidth-8, self.view.superview.safeAreaInsets.bottom + 80);

    self.view.frame = self.bottomFrame;
    
    
    UIImageView *swipeImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.swipeImage = swipeImage;
    [self.view addSubview:swipeImage];
    UIImage *image = [UIImage imageNamed:@"swipe"];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    swipeImage.image = image;
    [swipeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(8);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(5);
    }];
    
    
    
    UISwipeGestureRecognizer *swipeUP = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeUP.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUP];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
}

-(void)swipe:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionUp)
    {
        self.position--;
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionDown)
    {
        self.position++;
    }
}

-(void)setPosition:(NSInteger)position
{
    if (position != 10) {
        if (position>2) {
            position = 2;
        }
        if (position<=0) {
            position = 0;
        }
    }

    _position = position;
    
    switch (_position) {
        case 10:
        {
            [self hiddenScreen];
        }
            break;
        case 0:
        {
            [self showFullScreen];
        }
            break;
        case 1:
        {
            [self showCenterScreen];
        }
            break;
        case 2:
        {
            [self showBottomScreen];
        }
            break;
        default:
        {
            [self showFullScreen];

        }
            break;
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count<=1) {
        self.position = 2;
    }
    return [super popViewControllerAnimated:animated];
}

-(void)hiddenScreen
{
    [self.view endEditing:YES];
    self.swipeImage.hidden = YES;
    self.sideMenuViewController.panGestureEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = self.hiddenFrame;
    }];
}

-(void)showFullScreen
{
    [self.view endEditing:YES];
    self.swipeImage.hidden = YES;
    self.sideMenuViewController.panGestureEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = self.topFrame;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"topFullScreen" object:nil];
}

-(void)showCenterScreen
{
    self.swipeImage.hidden = NO;
    [self.view endEditing:YES];
    self.sideMenuViewController.panGestureEnabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = self.centerFrame;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"halfscreen" object:nil];
}

-(void)showBottomScreen
{
    self.swipeImage.hidden = NO;
    [self.view endEditing:YES];
    self.sideMenuViewController.panGestureEnabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = self.bottomFrame;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"halfscreen" object:nil];
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
