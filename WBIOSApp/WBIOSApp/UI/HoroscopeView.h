//
//  HoroscopeView.h
//  WBIOSApp
//
//  Created by LS on 11/7/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//  星座信息

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface HoroscopeView : UIView

@property (weak, nonatomic) IBOutlet StarView *multipleStarView;
@property (weak, nonatomic) IBOutlet StarView *loveStarView;
@property (weak, nonatomic) IBOutlet StarView *workStarView;
@property (weak, nonatomic) IBOutlet StarView *manageStarView;
@property (weak, nonatomic) IBOutlet UILabel *horoscopeLbl;
@property (weak, nonatomic) IBOutlet UILabel *luckyNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *luckyColorLbl;
@property (weak, nonatomic) IBOutlet UILabel *healthLbl;
@property (weak, nonatomic) IBOutlet UILabel *bussinessLbl;
@property (weak, nonatomic) IBOutlet UILabel *allLbl;
@property (weak, nonatomic) IBOutlet UILabel *connameLbl;


/**
 *  更新星座视图信息
 *
 *  @param array 星座信息
 */
- (void)updateHoroscopeInfo:(NSArray *)array;

@end
