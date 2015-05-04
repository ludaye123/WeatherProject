//
//  HoroscopeView.m
//  WBIOSApp
//
//  Created by LS on 11/7/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "HoroscopeView.h"

@implementation HoroscopeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.allLbl.contentMode = UIViewContentModeTop;
//    CGSize size = [self.allLbl.text boundingRectWithSize:CGSizeMake(self.allLbl.frame.size.width, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
////    CGSize size = [self.allLbl.text sizeWithFont:[UIFont systemFontOfSize:12.0] forWidth:self.allLbl.frame.size.width lineBreakMode:NSLineBreakByWordWrapping];
//    CGRect rect = self.allLbl.frame;
//    rect.size.height = size.height;
//    self.allLbl.frame = rect;
}

- (void)updateHoroscopeInfo:(NSArray *)array
{
    NSString *rank = @"rank";
    NSString *value = @"value";
    NSDictionary *dict = [array objectAtIndex:0];
    [self.multipleStarView setStarToImageViewBy:[[dict objectForKey:rank] intValue]];
    dict = [array objectAtIndex:1];
    [self.loveStarView setStarToImageViewBy:[[dict objectForKey:rank] intValue]];
    dict = [array objectAtIndex:2];
    [self.workStarView setStarToImageViewBy:[[dict objectForKey:rank] intValue]];
    dict = [array objectAtIndex:3];
    [self.manageStarView setStarToImageViewBy:[[dict objectForKey:rank] intValue]];
    dict = [array objectAtIndex:4];
    self.healthLbl.text = [dict objectForKey:value];
    dict = [array objectAtIndex:5];
    self.bussinessLbl.text = [dict objectForKey:value];
    dict = [array objectAtIndex:6];
    self.luckyColorLbl.text = [dict objectForKey:value];
    dict = [array objectAtIndex:7];
    self.luckyNumLbl.text = [dict objectForKey:value];
    dict = [array objectAtIndex:8];
    self.horoscopeLbl.text = [dict objectForKey:value];
    dict = [array objectAtIndex:9];
    self.allLbl.text = [dict objectForKey:value];
}

@end
