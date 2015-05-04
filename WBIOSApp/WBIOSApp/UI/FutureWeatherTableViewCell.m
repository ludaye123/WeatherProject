//
//  FutureWeatherTableViewCell.m
//  WBIOSApp
//
//  Created by LS on 4/13/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "FutureWeatherTableViewCell.h"

@implementation FutureWeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWeatherInfo:(id)info
{
    NSDictionary *dict = (NSDictionary *)info;
    self.weekName.text = dict[@"weekname"];
    self.tempLbl.text = self.isFahrenheitTem?dict[@"tempF"]:dict[@"temp"];
    self.weatherLbl.text = dict[@"weather"];
}

@end
