//
//  LSViewController.m
//  WBIOSApp
//
//  Created by LS on 9/16/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "MainViewController.h"
#import "ToolUnit.h"
#import "LSAppDelegate.h"
#import "WeatherView.h"
#import "SelectCityViewController.h"
#import "LifeHelpView.h"
#import <MFSideMenuContainerViewController.h>
#import <AFNetworking/AFNetworking.h>
#import <KissXML/DDXMLDocument.h>
#import "BMapKit.h"
#import "ShowWeatherView.h"
#import "ConstellationViewController.h"
#import "BTGlassScrollView.h"
#import "ScrollViewController.h"

#define CITY_REQUEST_URL @"http://mobile.weather.com.cn/js/citylist.xml"

#define NUMBER_OF_PAGES 5

@interface MainViewController () <UIScrollViewDelegate,ShowWeatherViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,ConstellationViewControllerDelegate,UIPageViewControllerDataSource, UIPageViewControllerDelegate,SelectCityViewControllerDelegate>
{
    NSMutableArray      *_cityInfos;
    BOOL                 _isOpenHoroscope;
    BMKLocationService  *_loacationService;
    BMKGeoCodeSearch    *_geoCodeSearch;
    NSMutableArray      *_viewControllerArray;
    int                  _currentIndex;
    CGFloat              _glassScrollOffset;
}

@property (strong ,nonatomic) ShowWeatherView *showWeatherView;
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation MainViewController

+ (id)loadViewController
{
    MainViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    return viewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _cityInfos = [[NSMutableArray alloc] initWithObjects:@"101280601",@"101250101", nil];

    _cityInfos = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [_appdelegate.database executeQuery:@"select * from selectcitymodel"];
    while ([resultSet next]) {
        
        NSString *cityid = [resultSet objectForColumnName:@"cityid"];
        NSString *cityName = [resultSet objectForColumnName:@"cityname"];
        CityModel *cityObjc = [[CityModel alloc] init];
        cityObjc.cityID = cityid;
        cityObjc.cityName = cityName;
        [_cityInfos  addObject:cityObjc];
    }
    
    _isOpenHoroscope = YES;

    
//    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.frame = self.view.bounds;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self loadDataForConsellation:@"6"];
    
//    [_combz fetchPM25By:PM25_REQUEST_URL(@"深圳") completionBlock:^(id responseResult) {
////        PM25Model *pm25 = [[PM25Model alloc] initWithDictionary:responseResult error:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
////            if(pm25)
////            {
////                [self.weatherView setPM25By:pm25];
////            }
//        });
//        
//    } failedBlock:^(id responseResult) {
//        NSLog(@"%@",responseResult);
//    }];

    
//TODO:BaiduMap Location
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    _loacationService = [[BMKLocationService alloc] init];
    _loacationService.delegate = self;
    [_loacationService startUserLocationService];
    
    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    _geoCodeSearch = geoCodeSearch;
    
    
    if(_cityInfos.count > 0)
    {
        [self showWeatherInfoView];
    }
    
    [self loadConstellationInfo];
    
 //**************************************************//
//    self.horoscopeBtn.hidden = YES;
}

- (void)showWeatherInfoView
{
    _viewControllerArray = [NSMutableArray array];
    _viewControllerArray[0] = [self glassScrollViewControllerForIndex:0];
    NSDictionary* options = @{UIPageViewControllerOptionInterPageSpacingKey : [NSNumber numberWithFloat:4.0f]};
    
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    [pageViewController setViewControllers:_viewControllerArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [pageViewController.view setBackgroundColor:[UIColor blackColor]];
    [pageViewController setDelegate:self];
    [pageViewController setDataSource:self];
    self.pageViewController = pageViewController;
    
    for (UIView *subview in pageViewController.view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *) subview;
            scrollview.delegate = self;
        }
    }

    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [self.view bringSubviewToFront:self.topView];
    [self.view bringSubviewToFront:self.horoscopeBtn];
    [self.view bringSubviewToFront:self.horoscopeView];
    [self.view insertSubview:_horoscopeView belowSubview:_horoscopeBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollAction:) name:kScrollNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFahrenheit:) name:kShowFahrenheitTemNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateConsellation:) name:kUpdateConstellationNotification object:nil];
    _geoCodeSearch.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kScrollNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kShowFahrenheitTemNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUpdateConstellationNotification object:nil];
    _geoCodeSearch.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ShowWeatherView *)createShowWeatherView:(NSString *)city
{
    ShowWeatherView *showWeatherView = [ShowWeatherView loadViewBy:city frame:CGRectMake(0.0, 0.0, kScreenSizeOfWidth, 320.0+2*kScreenSizeOfHeight)];
    showWeatherView.delegate = self;

    return showWeatherView;
}

/**
 *  加载已选择的星座
 */
- (void)loadConstellationInfo
{
    if([_comse fetchConname])
    {
        NSArray *array = [_comse fetchConstellationInfo];
        for(ConstellationModel *tempObjc in array)
        {
            if([tempObjc.conname isEqualToString:[_comse fetchConname]])
            {
                [self.horoscopeBtn setImage:[UIImage imageNamed:tempObjc.conimageName] forState:UIControlStateNormal];
                [self loadDataForConsellation:tempObjc.contype];
                self.horoscopeView.connameLbl.text = tempObjc.conname;
                break;
            }
        }
    }
}

#pragma mark - Location Delegate

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    
//    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
//    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
//    
//    BOOL flag = [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
//    if(flag)
//    {
//        NSLog(@"search successful");
//    }
//    else
//    {
//        NSLog(@"search failed");
//    }
}


#pragma mark - BaiduMapLocationDelegate

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{    
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;

    BOOL flag = [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    if(flag)
    {
        NSLog(@"search successful");
    }
    else
    {
        NSLog(@"search failed");
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if(error == 0) {
//        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//        item.coordinate = result.location;
//        item.title = result.address;
//        NSString* titleStr;
//        NSString* showmeg;
//        titleStr = @"反向地理编码";
//        showmeg = [NSString stringWithFormat:@"%@",item.title];
//        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
//        [myAlertView show];
        
        if(_cityInfos.count == 0)
        {
            if(result.addressDetail.city.length > 0)
            {
                NSString *cityname = [result.addressDetail.city substringToIndex:result.addressDetail.city.length-1];
                FMResultSet *result = [_appdelegate.database executeQuery:@"select * from citymodel where cityName = ?",cityname];
                
                CityModel *cityObjc = [[CityModel alloc] init];
                
                while ([result next]) {
                    
                    cityObjc.cityID = [result objectForColumnIndex:0];
                    cityObjc.cityName = [result objectForColumnIndex:1];
                    cityObjc.provinceName = [result objectForColumnIndex:2];
                }
                
                [_cityInfos addObject:cityObjc];
                [self saveToLocationInfo:cityObjc];
                [self showWeatherInfoView];
            }
        }
    }
}

- (void)saveToLocationInfo:(CityModel *)cityObjc
{
    NSString *cityID = cityObjc.cityID;
    [_combz fetchTemInfoDetailBy:WEATHER_REQUEST_URL_3(cityID) completionBlock:^(id responseResult) {
        
        NSError *__autoreleasing error;
        TemInfoDetailModel *tempInfoDetalObjc = [[TemInfoDetailModel alloc] initWithDictionary:responseResult error:&error];
        NSLog(@"%@",tempInfoDetalObjc);
        
        if(!error)
        {
            [_appdelegate.database executeUpdate:@"insert into selectcitymodel values(?,?,?)",cityID,tempInfoDetalObjc.city,tempInfoDetalObjc.temp1];
        }
    } failedBlock:^(id responseResult) {
        
        NSLog(@"%@",responseResult);
    }];
}


#pragma mark - loadRequest

/**
 *  发送请求加载星座信息
 *
 *  @param contype 星座类型
 */
- (void)loadDataForConsellation:(NSString *)contype
{
    [_combz fetchHoroscopeBy:CONSTELLATION_REQUEST_URL(contype) completionBlock:^(id responseResult) {
        NSLog(@"%@",responseResult);
        NSArray *array = (NSArray *)responseResult;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(array)
            {
                [self.horoscopeView updateHoroscopeInfo:array];
            }
        });
        
    } failedBlock:^(id responseResult) {
        NSLog(@"%@",responseResult);
    }];
}

#pragma mark - Notification Events

//左边侧滑
- (void)scrollAction:(NSNotification *)notification
{
    int offset = [[notification object] intValue] - 1;
    [self switchPageBy:offset];
}

- (void)showFahrenheit:(NSNotification *)notification
{
    NSDictionary *dict = [notification object];
    
    for(ScrollViewController *viewController in _viewControllerArray)
    {
        if([[dict objectForKey:@"state"] intValue] == 1)
        {
            [viewController showFahrenheitTem];
        }
        else
        {
            [viewController showCelsiusTem];
        }
    }
}

- (void)updateConsellation:(NSNotification *)notification
{
    ConstellationModel *tempObjc = [notification object];
    
    [self.horoscopeBtn setImage:[UIImage imageNamed:tempObjc.conimageName] forState:UIControlStateNormal];
    [self loadDataForConsellation:tempObjc.contype];
    self.horoscopeView.connameLbl.text = tempObjc.conname;
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.horoscopeBtn.hidden = scrollView.contentOffset.y < kScreenSizeOfHeight? NO : YES;
//    } completion:nil];
//}

- (void)switchPageBy:(int)page
{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = CGPointMake(0.0, page*kScreenSizeOfHeight);
    }];
}

- (void)rotaionAction:(id)sender
{
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.duration = 0.7f;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = 1;
//    [_imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)menuAction:(id)sender
{
    [_appdelegate.container toggleLeftSideMenuCompletion:nil];
}

- (void)setAction:(id)sender
{
    [_appdelegate.container toggleRightSideMenuCompletion:nil];
}

- (IBAction)horoscopeAction:(id)sender
{
    _isOpenHoroscope = !_isOpenHoroscope;
    if(!_isOpenHoroscope)
    {
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = self.horoscopeView.frame;
            rect.origin.y = 20;
            self.horoscopeView.frame = rect;
            
            rect = self.scrollView.frame;
            rect.origin.y = -20;
            self.scrollView.frame = rect;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = self.horoscopeView.frame;
            rect.origin.y = -CGRectGetHeight(self.horoscopeView.frame);
            self.horoscopeView.frame = rect;
            
            rect = self.scrollView.frame;
            rect.origin.y = 0;
            self.scrollView.frame = rect;
        }];
    }
}

- (void)selectCityAction:(id)sender
{
    SelectCityViewController *selectViewController = [[SelectCityViewController alloc] initWithNibName:@"SelectCityViewController" bundle:nil];
    selectViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:selectViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - ShowWeatherViewDelegate

- (void)showWeatherView:(ShowWeatherView *)view updateCity:(NSString *)city
{
    [self.cityBtn setTitle:city forState:UIControlStateNormal];
}

- (void)constellationViewController:(ConstellationViewController *)viewController didFinishedSelect:(ConstellationModel *)tempObjc
{
    [_appdelegate.container setMenuState:MFSideMenuStateClosed];
    
    [self.horoscopeBtn setImage:[UIImage imageNamed:tempObjc.conimageName] forState:UIControlStateNormal];
    [self loadDataForConsellation:tempObjc.contype];
    self.horoscopeView.connameLbl.text = tempObjc.conname;
    [_comse saveConname:tempObjc.conname];
}

- (ScrollViewController *)glassScrollViewControllerForIndex:(int)index
{
    ScrollViewController *viewController = [[ScrollViewController alloc] initWithImage:[UIImage imageNamed:@"bg1"] cityInfo:[_cityInfos objectAtIndex:index]];
    viewController.index = index;
    
    return viewController;
}


#pragma mark - Delegate & Datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ScrollViewController *currentGlass = (ScrollViewController *)viewController;
    _currentIndex = currentGlass.index;
    int replacementIndex = _currentIndex - 1;

    CityModel *cityObjc = [_cityInfos objectAtIndex:_currentIndex];
    [self.cityBtn setTitle:cityObjc.cityName forState:UIControlStateNormal];
    [currentGlass fetchRealTimeTemInfo];
    
    if (replacementIndex < 0) {
        return nil;
    }
    
    return _viewControllerArray[replacementIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ScrollViewController *currentGlass = (ScrollViewController *)viewController;
    _currentIndex = currentGlass.index;
    int replacementIndex = _currentIndex + 1;
    
    CityModel *cityObjc = [_cityInfos objectAtIndex:_currentIndex];
    [self.cityBtn setTitle:cityObjc.cityName forState:UIControlStateNormal];

    [currentGlass fetchRealTimeTemInfo];

    if (replacementIndex == _cityInfos.count) {
        return nil;
    }
    
    ScrollViewController *replacementViewController;
    if (_viewControllerArray.count == replacementIndex) {
        replacementViewController = [self glassScrollViewControllerForIndex:replacementIndex];
        _viewControllerArray[replacementIndex] = replacementViewController;
    } else {
        replacementViewController = _viewControllerArray[replacementIndex];
    }
    return replacementViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    ScrollViewController *glassVC = _viewControllerArray[_currentIndex];
    ScrollViewController *pendingGlassVC =  pendingViewControllers[0];
    [pendingGlassVC.glassScrollView scrollVerticallyToOffset:glassVC.glassScrollView.foregroundScrollView.contentOffset.y];
    
    if (glassVC.glassScrollView.foregroundScrollView.contentOffset.y > 0) {
        
        [pendingGlassVC.glassScrollView blurBackground:YES];
    }
}

#pragma mark UIScrollview

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
    
//    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.horoscopeBtn.hidden = scrollView.contentOffset.y < kScreenSizeOfHeight? NO : YES;
//    } completion:nil];
    
    if (ratio == 0) {
        return;
    }
    
    [((ScrollViewController*)_viewControllerArray[_currentIndex]).glassScrollView scrollHorizontalRatio:-ratio];
    if (_currentIndex != 0) {
        [((ScrollViewController*)_viewControllerArray[_currentIndex - 1]).glassScrollView scrollHorizontalRatio:-ratio-1];
    }
    if (_currentIndex != (_viewControllerArray.count - 1)) {
        [((ScrollViewController*)(_viewControllerArray[_currentIndex + 1])).glassScrollView scrollHorizontalRatio:-ratio+1];
    }
}

#pragma mark - SelectCityViewControllerDelegate

- (void)selectCityViewController:(SelectCityViewController *)viewController updateCityInfo:(BOOL)isUpdate
{
    if(isUpdate)
    {
        [_cityInfos removeAllObjects];
        [_viewControllerArray removeAllObjects];
       
        FMResultSet *resultSet = [_appdelegate.database executeQuery:@"select * from selectcitymodel"];
        while ([resultSet next]) {
            
            NSString *cityid = [resultSet objectForColumnName:@"cityid"];
            NSString *cityName = [resultSet objectForColumnName:@"cityname"];
            
            CityModel *cityObjc = [[CityModel alloc] init];
            cityObjc.cityID = cityid;
            cityObjc.cityName = cityName;
            [_cityInfos addObject:cityObjc];
        }
        
        _viewControllerArray[0] = [self glassScrollViewControllerForIndex:0];
        [self.pageViewController setViewControllers:_viewControllerArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

@end
