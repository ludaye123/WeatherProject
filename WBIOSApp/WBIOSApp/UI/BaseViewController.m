//
//  BaseViewController.m
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (id)loadViewController
{
    BaseViewController *viewController = [[BaseViewController alloc] init];

    return viewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _combz = [CommonBussiness shareInstance];
    _comse = [CommonStorage shareInstance];
    _appdelegate = APP_DELEGATE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeSideMenu
{
    [_appdelegate.container setMenuState:MFSideMenuStateClosed];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setTitleString:(NSString *)title
{
    self.nvItem.title = title;
}

- (void)createNavigationBar
{
    _nvItem = [[UINavigationItem alloc] init];
    _nvBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 64.0)];
    _nvBar.translucent = NO;
    [_nvBar setBarTintColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
    [_nvBar pushNavigationItem:_nvItem animated:YES];
    _nvBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_nvBar];
    NSDictionary *dict = NSDictionaryOfVariableBindings(_nvBar);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_nvBar]-0-|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_nvBar(64)]" options:0 metrics:nil views:dict]];
}

- (void)createBackHomeButton
{
    UIImage *image = [UIImage imageNamed:@"city_close@2x~iphone.png"];
    UIButton *backHome = [UIButton buttonWithType:UIButtonTypeCustom];
    [backHome setImage:image forState:UIControlStateNormal];
    backHome.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [backHome addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backHomeBtn = [[UIBarButtonItem alloc] initWithCustomView:backHome];
    _nvItem.leftBarButtonItem = backHomeBtn;
}

- (void)createEditButtom;
{    
//    UIImage *image = [UIImage imageNamed:@"city_edit@2x~iphone.png"];
//    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [editBtn setImage:image forState:UIControlStateNormal];
//    editBtn.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
//    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 15, image.size.height)];
//    view.backgroundColor = [UIColor grayColor];
//    UIBarButtonItem *lineBarButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    UIImage *imageHome = [UIImage imageNamed:@"city_add@2x~iphone.png"];
    UIButton *addCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCity setImage:imageHome forState:UIControlStateNormal];
    addCity.frame = CGRectMake(0.0, 0.0, imageHome.size.width, imageHome.size.height);
    [addCity addTarget:self action:@selector(addCityAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithCustomView:addCity];
    
    NSArray *items = @[addBtn];
    [_nvItem setRightBarButtonItems:items];
}

- (void)createTitleLblBy:(NSString *)title
{
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 21.0)];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor whiteColor];
    _nvItem.titleView = titleLbl;
}


- (void)createSearchViewBy:(NSString *)title
{
//    [_nvBar setBarTintColor:[UIColor whiteColor]];
     _searchTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds)-70.0, 30.0)];
    _searchTextFiled.borderStyle = UITextBorderStyleNone;
    _searchTextFiled.placeholder = title;
    _searchTextFiled.textColor = [UIColor whiteColor];
    _searchTextFiled.font = [UIFont systemFontOfSize:15.0];
    _searchTextFiled.textAlignment = NSTextAlignmentLeft;
    _searchTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextFiled.delegate = self;
    _searchTextFiled.returnKeyType = UIReturnKeyDone;
    
    [_searchTextFiled addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UIImage *image = [UIImage imageNamed:@"city_search~iphone"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    imageView.image = image;
    
    _searchTextFiled.leftView = imageView;
    _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *view = [[UIView alloc] initWithFrame:_searchTextFiled.bounds];
//    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [view addSubview:_searchTextFiled];
    
    _nvItem.titleView = view;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)doneAction:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)editAction:(UIButton *)sender
{
}

- (void)addCityAction:(UIButton *)sender
{
    
}

- (void)createCalcelButton
{
    UIImage *image = [UIImage imageNamed:@"city_close@2x~iphone.png"];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backHomeBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    _nvItem.rightBarButtonItem = backHomeBtn;
}

- (void)cancelAction:(UIButton *)sender
{
}

@end
