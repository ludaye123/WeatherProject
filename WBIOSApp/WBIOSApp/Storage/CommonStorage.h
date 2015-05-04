//
//  CityInfoStorage.h
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseStorage.h"
#import "APPDataModel.h"

@interface CommonStorage : BaseStorage

+ (id)shareInstance;

- (NSArray *)fetchAllCityInfo;
- (NSArray *)fetchConstellationInfo;

- (void)saveConname:(NSString *)conname;
- (NSString *)fetchConname;

- (void)saveCurrentCityInfo:(RealTimeTemModel *)realTimeObjc;
- (RealTimeTemModel *)fetchCurrentCityInfo;

- (void)saveBackGrourdImage:(NSString *)imageName;
- (NSString *)fetchBackGroundImage;

@end
