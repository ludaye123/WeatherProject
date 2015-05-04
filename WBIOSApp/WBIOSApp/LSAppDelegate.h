//
//  LSAppDelegate.h
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MFSideMenu.h>
#import "APPDataModel.h"

@class FMDatabase;
@class FMDatabaseQueue;

extern RealTimeTemModel *realTimeTemObjc;

@interface LSAppDelegate : UIResponder <UIApplicationDelegate>
{
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MFSideMenuContainerViewController *container;
@property (strong, nonatomic) FMDatabase *database;
@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;

@end
