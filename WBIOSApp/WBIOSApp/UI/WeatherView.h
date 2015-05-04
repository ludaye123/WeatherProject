//
//  WeatherView.h
//  WBIOSApp
//
//  Created by LS on 11/6/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface WeatherView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *currentTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *minTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherLbl;
@property (weak, nonatomic) IBOutlet UILabel *pm25Lbl;
@property (weak, nonatomic) IBOutlet UILabel *symbolLbl;

- (void)setTemInfoBy:(TemInfoModel *)tempInfoModel;
- (void)setTemBy:(RealTimeTemModel *)temModel;
- (void)setPM25By:(PM25Model *)pm25;

- (void)showFahrenheitTem;
- (void)showCelsiusTem;


@end
