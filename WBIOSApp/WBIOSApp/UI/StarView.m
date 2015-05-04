//
//  StarView.m
//  WBIOSApp
//
//  Created by LS on 11/7/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "StarView.h"

@implementation StarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setStarToImageViewBy:(int)numOfStar
{
    NSArray *tempArray = [NSArray arrayWithObjects:_starImageView1,_starImageView2,_starImageView3,_starImageView4,_starImageView5, nil];

    for(int i = 0; i < numOfStar; i++)
    {
        UIImageView *tempImgView = [tempArray objectAtIndex:i];
        tempImgView.image = [UIImage imageNamed:@"horoscope_full_stare@2x~iphone.png"];
    }
}

@end
