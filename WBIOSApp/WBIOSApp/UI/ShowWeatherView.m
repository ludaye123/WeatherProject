//
//  ShowWeatherView.m
//  WBIOSApp
//
//  Created by LS on 3/3/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "ShowWeatherView.h"
#import "WeatherView.h"
#import "FutureWeatherView.h"
#import "LifeHelpView.h"
#import <TSMessages/TSMessage.h>

@interface ShowWeatherView ()
{
    NSString *_currentNumber;
}

@property (strong, nonatomic) WeatherView *weatherView;
@property (strong, nonatomic) FutureWeatherView *futureWeatherView;
@property (strong, nonatomic) LifeHelpView *indexView;
@property (strong, nonatomic) RealTimeTemModel *realTimeTemObjc;

@end

@implementation ShowWeatherView

+ (id)loadView
{
    ShowWeatherView *view = [[ShowWeatherView alloc] init];
    
    return view;
}

+ (id)loadViewBy:(NSString *)areaNumber frame:(CGRect)frame
{
    ShowWeatherView *view = [[ShowWeatherView alloc] initWithAreaNumber:areaNumber frame:frame];
    
    return view;
}

- (id)initWithAreaNumber:(NSString *)areaNumber frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _combz = [CommonBussiness shareInstance];
        
        //天气信息
        WeatherView *weatherView = [WeatherView loadView];
        weatherView.frame = CGRectMake(5.0, 5.0, kScreenSizeOfWidth-10.0, 280.0);
        [self addSubview:weatherView];
        _weatherView = weatherView;

        //未来天气信息
        FutureWeatherView *futureWetahterView = [FutureWeatherView loadView];
        futureWetahterView.frame = CGRectMake(5.0, 300.0, kScreenSizeOfWidth-10.0, kScreenSizeOfHeight-200);
        [self addSubview:futureWetahterView];
        _futureWeatherView = futureWetahterView;

        //生活帮助
        LifeHelpView *indexView = [LifeHelpView loadView];
        indexView.frame = CGRectMake(5.0, 120.0+kScreenSizeOfHeight, kScreenSizeOfWidth-10.0, kScreenSizeOfHeight+100.0);
        [self addSubview:indexView];
        _indexView = indexView;
        
        
        _currentNumber = areaNumber;
        [self loadRealTemInfoDataBy:areaNumber];
        [self loadTemInfoDetailDataBy:areaNumber];
    }
    
    return self;
}

- (void)updateWeatherInfo
{
   if(_currentNumber.length > 0)
   {
       [self loadRealTemInfoDataBy:_currentNumber];
       [self loadTemInfoDetailDataBy:_currentNumber];
   }
}

//获取天气实时信息
- (void)loadRealTemInfoDataBy:(NSString *)areaNumber
{
    [_combz fetchTemBy:WEATHER_REQUEST_URL_1(areaNumber) completionBlock:^(id responseResult) {
        
        NSError *error;
        RealTimeTemModel *temModel = [[RealTimeTemModel alloc] initWithDictionary:responseResult error:&error];
        NSLog(@"%@",temModel);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(!error)
            {
                self.realTimeTemObjc = temModel;
                [self.weatherView setTemBy:temModel];
                if(self.delegate && [self.delegate respondsToSelector:@selector(showWeatherView:updateCity:)])
                {
                    [self.delegate showWeatherView:self updateCity:temModel.cityName];
                }
                [self fetchRealTimeTemInfo];
            }
        });
    } failedBlock:^(id responseResult) {
        NSLog(@"%@",responseResult);
    }];
}

//获取天气详细信息
- (void)loadTemInfoDetailDataBy:(NSString *)areaNumber
{
    [_combz fetchTemInfoDetailBy:WEATHER_REQUEST_URL_3(areaNumber) completionBlock:^(id responseResult) {
        
        
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"成功", nil)
                                    subtitle:NSLocalizedString(@"获取天气信息成功!", nil)
                                        type:TSMessageNotificationTypeSuccess];
        
        NSError *__autoreleasing error;
        TemInfoDetailModel *tempInfoDetalObjc = [[TemInfoDetailModel alloc] initWithDictionary:responseResult error:&error];
        if(!error)
        {
            NSLog(@"%@",tempInfoDetalObjc);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                TemInfoModel *tempInfoObjc = [[TemInfoModel alloc] init];
                tempInfoObjc.city = tempInfoDetalObjc.city;
                tempInfoObjc.cityid = tempInfoDetalObjc.cityid;
                NSArray *tempArray = [tempInfoDetalObjc.temp1 componentsSeparatedByString:@"~"];
                tempInfoObjc.temp1 = [tempArray lastObject];
                tempInfoObjc.temp2 = [tempArray firstObject];
                
                tempArray =[tempInfoDetalObjc.tempF1 componentsSeparatedByString:@"~"];
                tempInfoObjc.tempF1 = [tempArray lastObject];
                tempInfoObjc.tempF2 = [tempArray firstObject];
                
                tempInfoObjc.weather = tempInfoDetalObjc.weather1;
                [self.weatherView setTemInfoBy:tempInfoObjc];
                [_indexView updateContentForCell:tempInfoDetalObjc];
                [_futureWeatherView updateFutureWeatherInfo:tempInfoDetalObjc];
            });
        }
    } failedBlock:^(id responseResult) {
        NSLog(@"%@",responseResult);
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"失败", nil)
                                    subtitle:NSLocalizedString(@"获取天气信息失败!", nil)
                                        type:TSMessageNotificationTypeError];
    }];
}

//显示华氏温度
- (void)showFahrenheitTem
{
    [self.weatherView showFahrenheitTem];
    [self.futureWeatherView setFahrenheitTem:YES];
}

//显示摄氏温度
- (void)showCelsiusTem
{
    [self.weatherView showCelsiusTem];
    [self.futureWeatherView setFahrenheitTem:NO];
}

- (void)fetchRealTimeTemInfo
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(showWeatherView:realTimeTem:)])
    {
        [self.delegate showWeatherView:self realTimeTem:self.realTimeTemObjc];
    }
}

@end
