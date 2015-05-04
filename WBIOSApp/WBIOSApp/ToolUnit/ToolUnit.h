//
//  ToolUnit.h
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScaleSize 800

@interface ToolUnit : NSObject

+ (NSString *)md5:(NSString *)string;
+ (NSString *)encryptByAES:(NSString *)proclaimtext andKey:(NSString *)key;
+ (NSString *)dencryptByAES:(NSString *)ciphertext andKey:(NSString *)key;

+ (CGSize)scaleSize:(CGSize)sourceSize;
+ (UIImage *)scale:(UIImage *)sourceImg toSize:(CGSize)size;

+ (BOOL)isExistTable:(NSString *)tableName;
+ (UIViewController *)loadFromStoryboard:(NSString *)boardName className:(NSString *)className;

@end
