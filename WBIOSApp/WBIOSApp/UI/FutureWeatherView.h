//
//  FutureWeatherView.h
//  WBIOSApp
//
//  Created by LS on 4/13/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseView.h"

@interface FutureWeatherView : BaseView

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)updateFutureWeatherInfo:(TemInfoDetailModel *)temInfoDetailObjc;
- (void)setFahrenheitTem:(BOOL)isFahrenheitTem;

@end
