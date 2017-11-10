//
//  HTLiveWeatherInfoView.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/10.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTLiveWeatherInfoView.h"
#import "HTColor.h"
#import <Masonry.h>

@interface HTLiveWeatherInfoView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *reportTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@end

@implementation HTLiveWeatherInfoView

-(void)updateLiveWeather:(AMapLocalWeatherLive *)liveWeather
{
    _liveWeather = liveWeather;
    
    if (_liveWeather.city == nil) {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
    
    self.cityLabel.text = [NSString stringWithFormat:@"%@ %@",_liveWeather.city,_liveWeather.weather];
    
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@℃",_liveWeather.temperature];
    
    self.windDirectionPowerLabel.text = [NSString stringWithFormat:@"%@风%@级",_liveWeather.windDirection,_liveWeather.windPower];
    
    self.humidityLabel.text = [NSString stringWithFormat:@"湿度:%@",_liveWeather.humidity];
    
    NSString *time = [_liveWeather.reportTime componentsSeparatedByString:@" "].firstObject;
    self.reportTimeLabel.text = [NSString stringWithFormat:@"发布时间:%@",time];
    
    
    self.weatherLabel.text = [_liveWeather.weather substringToIndex:1];
    
    
    if ([_liveWeather.weather containsString:@"晴"])
    {
        self.weatherIcon.image = [UIImage imageNamed:@"weather_0"];
    }
    else if ([_liveWeather.weather containsString:@"阴"])
    {
        self.weatherIcon.image = [UIImage imageNamed:@"weather_1"];
    }
    else if ([_liveWeather.weather containsString:@"雨"]&&![_liveWeather.weather containsString:@"雷"])
    {
        self.weatherIcon.image = [UIImage imageNamed:@"weather_2"];
    }
    else if ([_liveWeather.weather containsString:@"雷"])
    {
        self.weatherIcon.image = [UIImage imageNamed:@"weather_3"];
    }
    else
    {
        self.weatherIcon.image = [UIImage imageNamed:@"weather_4"];
    }
    
    
}

+ (instancetype)loadView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.bgImage.layer.borderWidth = 1;
    self.bgImage.layer.borderColor = [HTColor textColor_999999].CGColor;
    self.bgImage.layer.cornerRadius = 5;
    self.bgImage.clipsToBounds = YES;
    
    self.rightView.layer.cornerRadius = 5;
    self.rightView.clipsToBounds = YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeWeatherView:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
 
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWeatherView:)];
    [self addGestureRecognizer:tap];
}

-(void)didMoveToSuperview
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview).mas_offset(-140);
        make.top.equalTo(self.superview).mas_offset([[UIApplication sharedApplication] statusBarFrame].size.height+8);
    }];
}




//点击天气标签
-(void)tapWeatherView:(UITapGestureRecognizer *)swipe
{
    [self showWeatherView];
}
//滑动天气标签
-(void)swipeWeatherView:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self hiddenWeatherView];
    }
}

//显示天气标签
-(void)showWeatherView
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview).mas_offset(8);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.rightView.alpha = 0;
        [self.superview layoutIfNeeded];
    }];
}

//隐藏天气标签
-(void)hiddenWeatherView
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview).mas_offset(-140);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.rightView.alpha =1;
        [self.superview layoutIfNeeded];
    }];
}

@end
