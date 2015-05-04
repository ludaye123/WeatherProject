//
//  BaseView.m
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

+ (id)loadView
{
    BaseView *view = [[BaseView alloc] init];
    
    return view;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _combz = [CommonBussiness shareInstance];
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
