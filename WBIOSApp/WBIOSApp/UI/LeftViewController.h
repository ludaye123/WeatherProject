//
//  LeftViewController.h
//  WBIOSApp
//
//  Created by LS on 11/6/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ScrollType)
{
    ScrollTypeWeather = 0,
    ScrollTypeTrend   = 1 << 1,
    ScrollTypeIndex   = 1 << 2
};

@interface LeftViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *weatherBtn;

- (IBAction)clickAction:(UIButton *)sender;
- (IBAction)shareAction:(id)sender;

@end


