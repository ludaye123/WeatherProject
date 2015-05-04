//
//  StarView.h
//  WBIOSApp
//
//  Created by LS on 11/7/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *starImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView5;

- (void)setStarToImageViewBy:(int)numOfStar;

@end
