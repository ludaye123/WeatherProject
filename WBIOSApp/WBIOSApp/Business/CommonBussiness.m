//
//  CommonBussiness.m
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "CommonBussiness.h"

@implementation CommonBussiness

+ (id)shareInstance
{
    static CommonBussiness *combz = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        combz = [[CommonBussiness alloc] init];
    });
    return combz;
}

- (void)fetchTemBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock
{
    [self getRequestToService:request completionBlock:completionBlock failedBlock:failedBlock];
}

- (void)fetchTemInfoBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock
{
    [self getRequestToService:request completionBlock:completionBlock failedBlock:failedBlock];
}

- (void)fetchTemInfoDetailBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock
{
//    [self getRequestToService:request completionBlock:completionBlock failedBlock:failedBlock];
    [self getWeatherInfoRequestToService:request completionBlock:completionBlock failedBlock:failedBlock];
}

- (void)fetchPM25By:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock
{
    NSString *newRequest = [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getPM25RequestToService:newRequest completionBlock:completionBlock failedBlock:failedBlock];
}

- (void)fetchHoroscopeBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock
{
    [self getHoroscopeRequestToService:request completionBlock:completionBlock failedBlock:failedBlock];
}

@end
