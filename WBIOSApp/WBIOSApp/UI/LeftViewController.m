//
//  LeftViewController.m
//  WBIOSApp
//
//  Created by LS on 11/6/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "LeftViewController.h"
#import "MainViewController.h"
#import <MFSideMenuContainerViewController.h>
#import <ShareSDK/ShareSDK.h>

@interface LeftViewController ()
{
    UIButton *_currentBtn;
}

@end

@implementation LeftViewController

+ (id)loadViewController
{
    LeftViewController *viewController = (LeftViewController *)[ToolUnit loadFromStoryboard:@"Main" className:NSStringFromClass([LeftViewController class])];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(50, 50, 50);
    _weatherBtn.backgroundColor = [UIColor blackColor];
    _currentBtn = _weatherBtn;
}

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

- (void)clickAction:(UIButton *)sender
{
    if(_currentBtn)
        _currentBtn.backgroundColor = [UIColor clearColor];
    
    sender.backgroundColor = [UIColor blackColor];
    _currentBtn = sender;
    [self closeSideMenu];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kScrollNotification object:[NSNumber numberWithInteger:_currentBtn.tag]];
}

- (void)shareAction:(id)sender
{
    [self closeSideMenu];
    
    NSString *currentWeatherInfo = [NSString stringWithFormat:@"当前温度:%@ 湿度:%@ 风速:%@ 点击查看更多",realTimeTemObjc.temp,realTimeTemObjc.sd,realTimeTemObjc.ws];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"AppIcon60x60" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content: currentWeatherInfo
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:[NSString stringWithFormat:@"%@实时天气信息",realTimeTemObjc.cityName]
                                                  url:[NSString stringWithFormat:@"http://m.weather.com.cn/mweather/%@.shtml",realTimeTemObjc.areaID]
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

@end
