//
//  MainPageViewController.m
//  WBIOSApp
//
//  Created by LS on 4/17/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "MainPageViewController.h"
#import "ScrollViewController.h"

@interface MainPageViewController ()
{
    NSMutableArray *_viewControllerArray;
    int _currentIndex;
    CGFloat _glassScrollOffset;
    NSMutableArray *_cityInfos;
}

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cityInfos = [[NSMutableArray alloc] init];
    
    _viewControllerArray = [NSMutableArray array];
    _viewControllerArray[0] = [self glassScrollViewControllerForIndex:0];
    
}


//- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
//{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (ScrollViewController *)glassScrollViewControllerForIndex:(int)index
{
    ScrollViewController *viewController = [[ScrollViewController alloc] initWithImage:[UIImage imageNamed:@"bg1"] cityInfo:[_cityInfos objectAtIndex:index]];
    
    
    return viewController;
}

@end
