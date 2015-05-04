//
//  IndexCollectionViewCell.h
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *indexImageView;
@property (weak, nonatomic) IBOutlet UILabel *indexNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;

- (void)updateContentInfo:(IndexModel *)indexObjc;

@end
