//
//  BaseViewController.h
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonBussiness.h"
#import "CommonStorage.h"
#import "LSAppDelegate.h"

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define APP_DELEGATE  (LSAppDelegate *)([UIApplication sharedApplication].delegate)

@interface BaseViewController : UIViewController <UITextFieldDelegate>
{
    CommonBussiness *_combz;
    CommonStorage   *_comse;
    LSAppDelegate   *_appdelegate;
}

@property (strong, nonatomic) UINavigationItem *nvItem;
@property (strong, nonatomic) UINavigationBar *nvBar;
@property (strong, nonatomic) UITextField *searchTextFiled;

- (void)closeSideMenu;
- (void)createNavigationBar;
- (void)createBackHomeButton;
- (void)createEditButtom;
- (void)createCalcelButton;
- (void)createSearchViewBy:(NSString *)title;
- (void)createTitleLblBy:(NSString *)title;

- (void)backHomeAction:(UIButton *)sender;
- (void)setTitleString:(NSString *)title;
- (void)addCityAction:(UIButton *)sender;
- (void)editAction:(UIButton *)sender;
- (void)cancelAction:(UIButton *)sender;

+ (id)loadViewController;

@end
