//
//  ConstellationViewController.h
//  WBIOSApp
//
//  Created by LS on 3/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseViewController.h"

@protocol ConstellationViewControllerDelegate;

@interface ConstellationViewController : BaseViewController
{
}
@property (assign, nonatomic) id<ConstellationViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSString *conname;

- (IBAction)backAction:(id)sender;

@end


@protocol ConstellationViewControllerDelegate <NSObject>

@optional
- (void)constellationViewController:(ConstellationViewController *)viewController didFinishedSelect:(ConstellationModel *)tempObjc;

@end