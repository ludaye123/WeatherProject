//
//  FutureWeatherTableViewCell.h
//  WBIOSApp
//
//  Created by LS on 4/13/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FutureWeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekName;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (weak, nonatomic) IBOutlet UILabel *weatherLbl;
@property (assign, nonatomic) BOOL isFahrenheitTem;


- (void)updateWeatherInfo:(id)info;

@end
