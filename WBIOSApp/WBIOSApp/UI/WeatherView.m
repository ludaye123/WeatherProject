//
//  WeatherView.m
//  WBIOSApp
//
//  Created by LS on 11/6/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "WeatherView.h"

@interface WeatherView ()
{
    RealTimeTemModel *_realtimeTemObjc;
    TemInfoModel *_tempInfoObjc;
}

@end

@implementation WeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)loadView
{
    WeatherView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WeatherView class]) owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

//- (void)loadData
//{
//    [_combz fetchTemBy:WEATHER_REQUEST_URL_1(@"101280601") completionBlock:^(id responseResult) {
//        
//        RealTimeTemModel *temModel = [[RealTimeTemModel alloc] initWithDictionary:responseResult error:nil];
//        NSLog(@"%@",temModel);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if(temModel)
//            {
//                [self setTemBy:temModel];
////                [self.cityBtn setTitle:temModel.cityName forState:UIControlStateNormal];
//            }
//        });
//    } failedBlock:^(id responseResult) {
//        NSLog(@"%@",responseResult);
//    }];
//}

- (void)setTemInfoBy:(TemInfoModel *)tempInfoModel
{
    _tempInfoObjc = tempInfoModel;
    self.weatherLbl.text = tempInfoModel.weather;
    self.minTempLbl.text = tempInfoModel.temp1;
    self.maxTempLbl.text = tempInfoModel.temp2;
}

- (void)setTemBy:(RealTimeTemModel *)temModel
{
    _realtimeTemObjc = temModel;
    NSString *currentTemStr = [NSString stringWithFormat:@"%@",[temModel.temp  substringToIndex:temModel.temp.length-1]];
    self.symbolLbl.text = @"℃";
    self.currentTempLbl.text = currentTemStr;
    NSString *humidityStr = [NSString stringWithFormat:@"湿度%@",temModel.sd];
    self.humidityLbl.text = humidityStr;
    NSString *windStr = [NSString stringWithFormat:@"%@\n%@",temModel.wd,temModel.ws];
    self.windLbl.text = windStr;
}

- (void)setPM25By:(PM25Model *)pm25
{
    NSString *pm25Str = [NSString stringWithFormat:@"%@ %@",pm25.aqi,pm25.quality];
    self.pm25Lbl.text = pm25Str;
}

- (void)showFahrenheitTem
{
//    ℉
    NSString *currentTemStr = [NSString stringWithFormat:@"%@",[_realtimeTemObjc.tempF  substringToIndex:_realtimeTemObjc.tempF.length-1]];
    self.currentTempLbl.text = currentTemStr;
    self.symbolLbl.text = @"℉";
    self.minTempLbl.text = _tempInfoObjc.tempF1;
    self.maxTempLbl.text = _tempInfoObjc.tempF2;
    [self adjustCurrentTemLblPosition];
}

- (void)showCelsiusTem
{
    NSString *currentTemStr = [NSString stringWithFormat:@"%@",[_realtimeTemObjc.temp  substringToIndex:_realtimeTemObjc.temp.length-1]];
    self.symbolLbl.text = @"℃";
    self.currentTempLbl.text = currentTemStr;
    self.weatherLbl.text = _tempInfoObjc.weather;
    self.minTempLbl.text = _tempInfoObjc.temp1;
    self.maxTempLbl.text = _tempInfoObjc.temp2;
    [self adjustCurrentTemLblPosition];
}

- (void)adjustCurrentTemLblPosition
{
    CGSize size = [self.currentTempLbl sizeThatFits:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.currentTempLbl.bounds))];
    CGRect rect = self.currentTempLbl.frame;
    rect.size.width = size.width;
    self.currentTempLbl.frame = rect;
    
    rect = self.symbolLbl.frame;
    rect.origin.x = CGRectGetMaxX(self.currentTempLbl.frame);
    self.symbolLbl.frame = rect;
}

@end
