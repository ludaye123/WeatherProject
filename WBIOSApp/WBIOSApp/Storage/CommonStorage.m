//
//  CityInfoStorage.m
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "CommonStorage.h"
#import <KissXML/DDXML.h> 

@interface CommonStorage ()

@end

static NSString *const kConname = @"conname";
static NSString *const kCurrentCityInfo = @"currentcityinfo";
static NSString *const kBackGroundImage = @"BackGroundImage";

@implementation CommonStorage

+ (id)shareInstance
{
    static CommonStorage *combz = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        combz = [[CommonStorage alloc] init];
    });
    return combz;
}
/*
 AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
 manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
 [manager GET:CITY_REQUEST_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //        NSLog(@"%@",operation.responseString);
 DDXMLDocument *xmlDocument = [[DDXMLDocument alloc] initWithXMLString:operation.responseString options:0 error:nil];
 DDXMLElement *rootElement = [xmlDocument rootElement];
 NSArray *elements = [rootElement children];
 for(DDXMLElement *element in elements)
 {
 NSArray *temp = [element children];
 for(DDXMLElement *tempElement in temp)
 {
 if([[tempElement name] isEqual:@"d"])
 {
 CityModel *cityModel = [[CityModel alloc] init];
 cityModel.cityID = [[tempElement attributeForName:@"d1"] stringValue];
 cityModel.cityName = [[tempElement attributeForName:@"d2"] stringValue];
 cityModel.spellName = [[tempElement attributeForName:@"d3"] stringValue];
 cityModel.provinceName = [[tempElement attributeForName:@"d4"] stringValue];
 [_cityInfos addObject:cityModel];
 }
 }
 }
 
 NSLog(@"%@",_cityInfos);
 NSMutableData *data = [[NSMutableData alloc] init];
 NSKeyedArchiver *keyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
 [keyedArchiver encodeObject:_cityInfos forKey:@"cityinfo"];
 [keyedArchiver finishEncoding];
 [data writeToFile:@"/Users/LS/Desktop/city.plist" atomically:YES];
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"%@",error);
 }];
 */

- (NSArray *)fetchAllCityInfo
{
    NSMutableArray *citys = [[NSMutableArray alloc] init];
    
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"chinacity" ofType:@"xml"];
    NSString *str = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:nil];
    
    DDXMLDocument *xmlDocument = [[DDXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    DDXMLElement *rootElement = [xmlDocument rootElement];
    NSArray *elements = [rootElement children];
    for(DDXMLElement *element in elements)
    {
        NSArray *temp = [element children];
        NSString *proviceStr = [[element attributeForName:@"name"] stringValue];
        
        for(DDXMLElement *tempElement in temp)
        {
            if([[tempElement name] isEqual:@"city"])
            {
                NSArray *childElements = [tempElement children];
                for(DDXMLElement *chileElement in childElements)
                {
                    if([[chileElement name] isEqualToString:@"county"])
                    {
                        CityModel *cityObjc = [[CityModel alloc] init];
                        cityObjc.cityID = [[chileElement attributeForName:@"weatherCode"] stringValue];
                        cityObjc.cityName = [[chileElement attributeForName:@"name"] stringValue];
//                        cityObjc.spellName = [[tempElement attributeForName:@"d3"] stringValue];
                        cityObjc.provinceName = proviceStr;
                        [citys addObject:cityObjc];
                    }
                }
            }
        }
    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
//    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
//
//    NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    NSArray *citys = [keyedUnarchiver decodeObjectForKey:@"cityinfo"];
//    [keyedUnarchiver finishDecoding];

    return citys;
}

- (NSArray *)fetchConstellationInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Constellation" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *array = [dict objectForKey:@"constellationkey"];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in array)
    {
        NSError *__autoreleasing error;
        ConstellationModel *constellationObjc = [[ConstellationModel alloc] initWithDictionary:dict error:&error];
        if(!error)
        {
            [tempArray addObject:constellationObjc];
        }
    }
    
    return tempArray;
}

- (void)saveConname:(NSString *)conname
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:conname forKey:kConname];
    [userDefaults synchronize];
}

- (NSString *)fetchConname
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kConname];
}

- (void)saveCurrentCityInfo:(RealTimeTemModel *)realTimeObjc
{
    NSUserDefaults *usersDefaults = [NSUserDefaults standardUserDefaults];
    [usersDefaults setObject:realTimeObjc forKey:kCurrentCityInfo];
    [usersDefaults synchronize];
}

- (RealTimeTemModel *)fetchCurrentCityInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityInfo];
}

- (void)saveBackGrourdImage:(NSString *)imageName
{
    NSUserDefaults *usersDefaults = [NSUserDefaults standardUserDefaults];
    [usersDefaults setObject:imageName forKey:kBackGroundImage];
    [usersDefaults synchronize];
}

- (NSString *)fetchBackGroundImage
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kBackGroundImage];
}

@end
