//
//  LSAppDelegate.m
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "LSAppDelegate.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "BMapKit.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WxApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TSMessages/TSMessageView.h>


@interface LSAppDelegate ()
{
    BMKMapManager *_mapManager;
}

@end

RealTimeTemModel *realTimeTemObjc = nil;

@implementation LSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    MainViewController *centerViewController = [MainViewController loadViewController];
    LeftViewController *leftMenuViewController = [LeftViewController loadViewController];
    RightViewController *rightMenuViewController = [RightViewController loadViewController];
    
    _container = [MFSideMenuContainerViewController containerWithCenterViewController:centerViewController
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:rightMenuViewController];
    _container.leftMenuWidth = 50;
    _container.panMode = MFSideMenuPanModeNone;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_container];
    navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [TSMessage setDefaultViewController:navigationController];
    
    //init db
    [self getDatabase];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:kFirstLauch])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstLauch];
        if(![ToolUnit isExistTable:[NSStringFromClass([CityModel class]) lowercaseString] ])
        {
            [_database executeUpdate:@"create table selectcitymodel (cityID text,cityName text,temInfo text)"];
            [_database executeUpdate:@"insert into selectcitymodel values(?,?,?)",@"101250101",@"长沙",@"24℃~20℃"];
           if([_database executeUpdate:@"create table citymodel (cityID text,cityName text,provinceName text)"])
           {
               CommonStorage *comStorage  = [CommonStorage shareInstance];
               NSArray *citys = [comStorage fetchAllCityInfo];
               for(CityModel *cityObjc in citys)
               {
                 BOOL ret = [_database executeUpdate:@"insert into citymodel values(?,?,?)",cityObjc.cityID,cityObjc.cityName,cityObjc.provinceName];
                   if(ret)
                   {
//                       NSLog(@"insert success");
                   }
               }
           }
        }
    }
    
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:kBaiduMapKey generalDelegate:nil];
    if(ret)
    {
        NSLog(@"百度地图授权成功");
    }
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    [ShareSDK registerApp:kShareSDKKey];
    
//    [ShareSDK registerApp:kShareSDKKey useAppTrusteeship:YES];
    [self registerThridApplication];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (FMDatabase *)getDatabase
{
    NSError *error;
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:kAppDatabaseName];
    success = [fileManager fileExistsAtPath:databasePath];
    if(!success)
    {
        NSString *defaultDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kAppDatabaseName];
        success = [fileManager copyItemAtPath:defaultDatabasePath toPath:databasePath error:&error];
        if(!success)
        {
            NSLog(@"Database Error%@",[error localizedDescription]);
        }
    }
    
    NSLog(@"Database Path:%@",databasePath);
    FMDatabase *database = [[FMDatabase alloc] initWithPath:databasePath];
    self.database = database ;
    self.databaseQueue = (FMDatabaseQueue *) [FMDatabaseQueue databaseQueueWithPath:databasePath];
    database.logsErrors = YES;
    if([database open])
    {
        [database setShouldCacheStatements:YES];
    }
    return database;
}




- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

/**
 *  注册第三方分享组件
 */
- (void)registerThridApplication
{
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"268994465"
                                appSecret:@"0f5405c55ad5cdb01052577942e0b299"
                              redirectUri:@"https://api.weibo.com/oauth2/default.html"
                              weiboSDKCls:[WeiboSDK class]];
    [ShareSDK connectWeChatWithAppId:@"wx0e83b8876abb1ff6" appSecret:@"c5f72a708c6bbbcd6bad5be84ce672fe" wechatCls:[WXApi class]];
}

@end
