//
//  LifeHelpView.h
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseView.h"

@interface LifeHelpView : BaseView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateContentForCell:(id)contents;

@end
