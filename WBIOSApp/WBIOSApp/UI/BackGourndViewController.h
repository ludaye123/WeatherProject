//
//  BackGourndViewController.h
//  WBIOSApp
//
//  Created by LS on 4/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseViewController.h"

@interface BackGourndViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)backAction:(id)sender;

@end
