//
//  CityViewController.h
//  WBIOSApp
//
//  Created by LS on 11/29/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseViewController.h"

@protocol CityViewControllerDelegate;

@interface CityViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bgImgView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) id<CityViewControllerDelegate> delegate;

@end

@protocol CityViewControllerDelegate <NSObject>

@optional
- (void)cityViewController:(CityViewController *)viewController didSelectedCity:(CityModel *)cityObjc;

@end