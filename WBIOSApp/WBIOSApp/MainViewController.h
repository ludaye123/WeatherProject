//
//  LSViewController.h
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WeatherView.h"
#import "HoroscopeView.h"


@interface MainViewController : BaseViewController
{
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *humidityImageView;
@property (weak, nonatomic) IBOutlet HoroscopeView *horoscopeView;
@property (weak, nonatomic) IBOutlet UIButton *horoscopeBtn;
@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)menuAction:(id)sender;
- (IBAction)setAction:(id)sender;
- (IBAction)selectCityAction:(id)sender;
- (IBAction)horoscopeAction:(id)sender;

@end
