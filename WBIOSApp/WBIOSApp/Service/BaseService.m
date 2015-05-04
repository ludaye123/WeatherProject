//
//  BaseService.m
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

- (void)postRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [httpRequestOperationManager POST:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        faildBlock(error);
    }];
}

- (void)getRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [httpRequestOperationManager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
        completionBlock([dict objectForKey:@"sk_info"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faildBlock(error);
    }];
}



- (void)getWeatherInfoRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [httpRequestOperationManager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
        completionBlock([dict objectForKey:@"weatherinfo"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faildBlock(error);
    }];
}

- (void)getPM25RequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock;
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [httpRequestOperationManager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
        completionBlock(array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faildBlock(error);
    }];
}

- (void)getHoroscopeRequestToService:(NSString *)requestURL completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)faildBlock
{
    AFHTTPRequestOperationManager *httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
    httpRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json", nil];
    [httpRequestOperationManager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        completionBlock(array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faildBlock(error);
    }];
}

@end
