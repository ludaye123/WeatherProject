//
//  SelectCityViewController.h
//  WBIOSApp
//
//  Created by LS on 11/29/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseViewController.h"

@protocol SelectCityViewControllerDelegate;

@interface SelectCityViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bgImgView;
@property (assign, nonatomic) id<SelectCityViewControllerDelegate> delegate;

@end

@protocol SelectCityViewControllerDelegate <NSObject>

@optional
- (void)selectCityViewController:(SelectCityViewController *)viewController didSelectCity:(CityModel *)cityObjc;
- (void)selectCityViewController:(SelectCityViewController *)viewController updateCityInfo:(BOOL)isUpdate;

@end

