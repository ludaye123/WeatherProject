//
//  BaseView.h
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPDataModel.h"
#import "CommonBussiness.h"

@interface BaseView : UIView
{
    CommonBussiness *_combz;
}

+ (id)loadView;

@end
