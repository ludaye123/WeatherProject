//
//  ShowWeatherView.h
//  WBIOSApp
//
//  Created by LS on 3/3/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseView.h"

@protocol ShowWeatherViewDelegate;

@interface ShowWeatherView : BaseView
{
    
}

@property (assign, nonatomic) id<ShowWeatherViewDelegate> delegate;

+ (id)loadViewBy:(NSString *)areaNumber frame:(CGRect)frame;

- (id)initWithAreaNumber:(NSString *)areaNumber frame:(CGRect)frame;
//显示华氏温度
- (void)showFahrenheitTem;
//显示摄氏温度
- (void)showCelsiusTem;
- (void)fetchRealTimeTemInfo;
- (void)updateWeatherInfo;
@end

@protocol ShowWeatherViewDelegate <NSObject>

@optional
- (void)showWeatherView:(ShowWeatherView *)view updateCity:(NSString *)city;
- (void)showWeatherView:(ShowWeatherView *)view realTimeTem:(RealTimeTemModel *)realTimeObjc;

@end
