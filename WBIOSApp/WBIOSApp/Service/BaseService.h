//
//  BaseService.h
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

- (void)postRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;
- (void)getRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;
- (void)getPM25RequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;
- (void)getHoroscopeRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;
- (void)getWeatherInfoRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;

@end
