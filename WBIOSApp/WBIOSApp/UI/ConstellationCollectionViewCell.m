//
//  ConstellationCollectionViewCell.m
//  WBIOSApp
//
//  Created by LS on 3/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "ConstellationCollectionViewCell.h"

@implementation ConstellationCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectImageView.hidden = YES;
}

- (void)showConsellationInfo:(ConstellationModel *)temObjc
{
    self.conImageView.image = [UIImage imageNamed:temObjc.conimageName];
    self.conNameLbl.text = [temObjc.conname substringToIndex:3];
}

@end
