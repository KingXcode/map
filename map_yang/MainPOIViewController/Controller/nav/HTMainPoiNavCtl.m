//
//  HTMainPoiNavCtl.m
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMainPoiNavCtl.h"
#import <RESideMenu.h>
#import "HTTransitionOne.h"

@interface HTMainPoiNavCtl ()<UINavigationControllerDelegate>

@property (nonatomic,assign) CGRect topFrame;
@property (nonatomic,assign) CGRect centerFrame;
@property (nonatomic,assign) CGRect bottomFrame;
@property (nonatomic,assign) CGRect hiddenFrame;
@property (nonatomic,assign) CGFloat lastoffset_y;


@property (nonatomic,weak) UIImageView * swipeImage;

@end

@implementation HTMainPoiNavCtl

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[HTTransitionOne alloc]initWithOperation:YES];
    }
    else
    {
        return nil;
    }
}


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
    
    self.delegate = self;
    
    self.navigationBar.tintColor = [HTColor textColor_666666];
    
    self.view.backgroundColor = [HTColor ht_whiteColor];
    self.view.layer.cornerRadius = 5;
    self.view.layer.borderColor = [HTColor textColor_666666].CGColor;
    self.view.layer.borderWidth = 0.5;
    self.view.clipsToBounds = YES;
    
    self.topFrame    = CGRectMake(0, 0, IphoneWidth, IphoneHeight);
    self.centerFrame = CGRectMake(4, IphoneHeight*0.5, IphoneWidth-8, IphoneHeight*0.5);
    self.bottomFrame = CGRectMake(4, IphoneHeight-(self.view.superview.safeAreaInsets.bottom + 70), IphoneWidth-8, self.view.superview.safeAreaInsets.bottom + 70);
    self.hiddenFrame = CGRectMake(4, IphoneHeight-(self.view.superview.safeAreaInsets.bottom), IphoneWidth-8, self.view.superview.safeAreaInsets.bottom + 70);

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
    
//    UISwipeGestureRecognizer *swipeUP = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
//    swipeUP.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:swipeUP];
//    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
//    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:swipeDown];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}
    


-(void)pan:(UIPanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.lastoffset_y = 0;
            CGPoint panStartPoint = [sender translationInView:self.view.superview];
            NSLog(@"-----Current State: Began-----");
            NSLog(@"start point (%f, %f) in View", panStartPoint.x, panStartPoint.y);
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [sender translationInView:self.view.superview];
            [self changeViewFrameByOffsetY:currentPoint.y];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            CGPoint endPoint = [sender translationInView:self.view.superview];
            [self endViewFrameByOffsetY:endPoint.y];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            self.position = _position;
            break;
        default:
            break;
    }
}

-(void)changeViewFrameByOffsetY:(CGFloat)offset_y
{
    CGFloat x = self.view.frame.origin.x;
    CGFloat y = self.view.frame.origin.y+offset_y-self.lastoffset_y;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height-offset_y+self.lastoffset_y;
    self.lastoffset_y = offset_y;
    self.view.frame = CGRectMake(x, y, w, h);
}

-(void)endViewFrameByOffsetY:(CGFloat)offset_y
{
    CGFloat y = self.view.frame.origin.y+offset_y-self.lastoffset_y;
    
    if (y<IphoneHeight*0.25)//回到顶部
    {
        self.position = 0;
    }
    else if (y>=IphoneHeight*0.25&&y<IphoneHeight*0.75)//回到中间
    {
        self.position = 1;
    }
    else//回到底部
    {
        self.position = 2;
    }
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
    if (_showScreenPosition) {
        _showScreenPosition(_position);
    }
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
    return [super popViewControllerAnimated:NO];
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
