//
//  ScrollViewController.m
//  WBIOSApp
//
//  Created by LS on 4/17/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "ScrollViewController.h"
#import "ShowWeatherView.h"
#import "LSAppDelegate.h"

@interface ScrollViewController ()<ShowWeatherViewDelegate,BTGlassScrollViewDelegate>

@property (strong, nonatomic) ShowWeatherView *weatherView;

@end

@implementation ScrollViewController


- (id)initWithImage:(UIImage *)image cityInfo:(CityModel *)cityObjc
{
    self = [super init];
    if(self)
    {
        self.weatherView = [self createShowWeatherView:cityObjc.cityID];
        _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:image blurredImage:nil viewDistanceFromBottom:280.0 foregroundView:self.weatherView];
        _glassScrollView.userInteractionEnabled = YES;
        [self.view addSubview:_glassScrollView];
        _glassScrollView.delegate = self;
        
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"refresh"];
        [refreshBtn setImage:image forState:UIControlStateNormal];
        refreshBtn.frame = CGRectMake(kScreenSizeOfWidth-image.size.width, 80.0, 16.0, 16.0);
        [_glassScrollView addSubview:refreshBtn];
        [refreshBtn addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

//- (id)initWithImage:(UIImage *)image cityInfo:(NSString *)cityid
//{
//    self = [super init];
//    if(self)
//    {
//        _glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:image blurredImage:nil viewDistanceFromBottom:280.0 foregroundView:[self createShowWeatherView:cityid]];
//        [self.view addSubview:_glassScrollView];
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([_comse fetchBackGroundImage].length > 0)
    {
        UIImage *bgImage = [UIImage imageNamed:[_comse fetchBackGroundImage]];
        [self.glassScrollView setBackgroundImage:bgImage overWriteBlur:YES animated:NO duration:0.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ShowWeatherView *)createShowWeatherView:(NSString *)city
{
//    ShowWeatherView *showWeatherView = [ShowWeatherView loadViewBy:city frame:CGRectMake(0.0, 0.0, kScreenSizeOfWidth, kScreenSizeOfHeight*2+320.0)];
    ShowWeatherView *showWeatherView = [ShowWeatherView loadViewBy:city frame:CGRectMake(0, 0, 320, 320.0+2*CGRectGetHeight(self.view.bounds)-100.0)];
    showWeatherView.delegate = self;
    
    return showWeatherView;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_glassScrollView scrollVerticallyToOffset:-_glassScrollView.foregroundScrollView.contentInset.top];
}

- (void)viewWillLayoutSubviews
{
    [_glassScrollView setTopLayoutGuideLength:[self.topLayoutGuide length]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showWeatherView:(ShowWeatherView *)view updateCity:(NSString *)city
{
    NSLog(@"%@",city);
}

- (void)showWeatherView:(ShowWeatherView *)view realTimeTem:(RealTimeTemModel *)realTimeObjc
{
//    [_comse saveCurrentCityInfo:realTimeObjc];
    realTimeTemObjc = realTimeObjc;
}

- (void)showFahrenheitTem
{
    ShowWeatherView *weatherView = (ShowWeatherView *)_glassScrollView.foregroundView;
    [weatherView showFahrenheitTem];
}

- (void)showCelsiusTem
{
    ShowWeatherView *weatherView = (ShowWeatherView *)_glassScrollView.foregroundView;
    [weatherView showCelsiusTem];
}

- (void)glassScrollView:(BTGlassScrollView *)glassScrollView didChangedToFrame:(CGRect)frame
{
    NSLog(@"change");
}

- (void)fetchRealTimeTemInfo
{
    [self.weatherView fetchRealTimeTemInfo];
}


#pragma mark - refresh action

- (void)refreshAction:(UIButton *)sender
{
    [self.weatherView updateWeatherInfo];
}

@end
