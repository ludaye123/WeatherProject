//
//  ConstellationCollectionViewCell.h
//  WBIOSApp
//
//  Created by LS on 3/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstellationCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *characterBtn;

@property (weak, nonatomic) IBOutlet UIImageView *conImageView;
@property (weak, nonatomic) IBOutlet UILabel *conNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

- (void)showConsellationInfo:(ConstellationModel *)temObjc;

@end
