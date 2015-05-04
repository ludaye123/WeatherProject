//
//  IndexCollectionViewCell.m
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "IndexCollectionViewCell.h"

@implementation IndexCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateContentInfo:(IndexModel *)indexObjc
{
    self.indexImageView.image = indexObjc.indexImage;
    self.indexNameLbl.text = indexObjc.indexName;
    self.indexLbl.text = indexObjc.index;
}

@end
