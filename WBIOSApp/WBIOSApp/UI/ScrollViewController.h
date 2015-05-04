//
//  ScrollViewController.h
//  WBIOSApp
//
//  Created by LS on 4/17/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseViewController.h"
#import "BTGlassScrollView.h"

@interface ScrollViewController : BaseViewController

@property (strong, nonatomic) BTGlassScrollView *glassScrollView;
@property (strong, nonatomic) CityModel *cityObjc;
@property (nonatomic, assign) int index;

- (id)initWithImage:(UIImage *)image cityInfo:(CityModel *)cityObjc;
//- (id)initWithImage:(UIImage *)image cityInfo:(NSString *)cityid;

- (void)showFahrenheitTem;
- (void)showCelsiusTem;
- (void)fetchRealTimeTemInfo;


@end
