//
//  CommonBussiness.h
//  WBIOSApp
//
//  Created by LS on 10/20/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseService.h"

@interface CommonBussiness : BaseService

+ (id)shareInstance;

//实时天气信息接口
- (void)fetchTemBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock;

- (void)fetchTemInfoBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock;

//天气详细信息接口
- (void)fetchTemInfoDetailBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock;

//PM2.5接口
- (void)fetchPM25By:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock;

//星座信息接口
- (void)fetchHoroscopeBy:(NSString *)request completionBlock:(ResponseSuccessBlock)completionBlock failedBlock:(ResponseFailedBlock)failedBlock;

@end
