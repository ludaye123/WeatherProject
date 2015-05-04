//
//  ToolUnit.m
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "ToolUnit.h"
#import "AES/AESCrypt.h"
#import "NSString+MD5Addition.h"
#import "LSAppDelegate.h"

@implementation ToolUnit

+ (NSString *)md5:(NSString *)string
{
    return [string stringFromMD5];
}

+ (NSString *)encryptByAES:(NSString *)proclaimtext andKey:(NSString *)key
{
    return [AESCrypt encrypt:proclaimtext password:key];
}

+ (NSString *)dencryptByAES:(NSString *)ciphertext andKey:(NSString *)key
{
    return [AESCrypt decrypt:ciphertext password:key];
}

+ (UIImage *)scale:(UIImage *)sourceImg toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [sourceImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height)
    {
        return CGSizeMake(kScaleSize, kScaleSize * height / width);
    }
    else
    {
        return CGSizeMake(kScaleSize * width / height, kScaleSize);
    }
}

+ (BOOL)isExistTable:(NSString *)tableName
{
    LSAppDelegate *appdelegate = (LSAppDelegate *)[[UIApplication sharedApplication] delegate];
    FMResultSet *resultSet = [appdelegate.database executeQuery: @"select count(*) as 'count' from sqlite_master where type='table' and name = ?",tableName];
    BOOL ret = NO;
    while ([resultSet next]) {
        
        NSInteger count = [resultSet intForColumn:@"count"];
        ret = 0 == count? NO : YES;
    }
    
    return ret;
}

+ (UIViewController *)loadFromStoryboard:(NSString *)boardName className:(NSString *)className{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:boardName bundle:[NSBundle mainBundle]];
    UIViewController * viewcontroller = [storyboard instantiateViewControllerWithIdentifier:className];
    return viewcontroller;
}

@end
