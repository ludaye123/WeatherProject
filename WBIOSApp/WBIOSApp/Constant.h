//
//  Constant.h
//  WBIOSApp
//
//  Created by LS on 10/18/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#ifndef WBIOSApp_Constant_h
#define WBIOSApp_Constant_h

#import <AFNetworking/AFNetworking.h>

/**
 星座运势接口，参数列表
 白羊座      0
 金牛座      1
 双子座      2
 巨蟹座      3
 狮子座      4
 处女座      5
 天秤座      6
 天蝎座      7
 射手座      8
 摩羯座      9
 水瓶座      10
 双鱼座      11
 */
#define CONSTELLATION_REQUEST_URL(ID) [NSString stringWithFormat:@"http://api.uihoo.com/astro/astro.http.php?fun=day&id=%@&format=json",ID]

/*
 1、http://www.weather.com.cn/data/sk/101280601.html
 
 2、http://www.weather.com.cn/data/cityinfo/101280601.html
 
 3、http://m.weather.com.cn/data/101280601.html   
 
 城市代码:101280601
 */

//http://m.weather.com.cn/ks/101280601.html?response=application/json
//http://m.weather.com.cn/ic/101280601.html?response=application/json


#define WEATHER_REQUEST_URL_1(CITY_ID) [NSString stringWithFormat:@"http://m.weather.com.cn/ks/%@.html?response=application/json",CITY_ID]
#define WEATHER_REQUEST_URL_2(CITY_ID) [NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html",CITY_ID]
//#define WEATHER_REQUEST_URL_3(CITY_ID) [NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",CITY_ID]
#define WEATHER_REQUEST_URL_3(CITY_ID) [NSString stringWithFormat:@"http://m.weather.com.cn/atad/%@.html",CITY_ID]


//http://m.weather.com.cn/atad/101280601.html
//http://m.weather.com.cn/atad/101290101.html?response=application/json
/*
 风向（wind direction）指风的来向。气象台常用八个方位发布风向的预报，
 即东（E）、南（S）、西（W）、北（ N）、东南（SE）、西南（SW）、
 西北（NW）和东北（NE）。风向观测是用十六个方位来表示的（如图），
 即在上述八个方位中间再增加北东北（NNE）、东东北（ENE）、
 东东南（ESE）、南东南（SSE）、南西南（SSW）、西西南（WSW）、
 西西北（WNW）和北西北（NNW下图误为 NWN）。
 实际测风报告中还经常用0－360°范围内的数字表示风向，
 以0°为北，90°为东，180°为南，270°为西，余类推
 。在天气预报中有时还用偏北风、偏南风等名称，偏字表示风向围绕某个方位作小范围摆动。
 
 <qw h="21" wd="23" fx="87" fl="2" js="0" sd="67"/>
 h 小时
 wd 温度
 fx 风向
 fl 风力
 js 降水
 sd 湿度
 http://flash.weather.com.cn/sk2/shikuang.swf?id=101280601
 http://flash.weather.com.cn/sk2/101280601.xml
 */

#define REAL_TIME_WEATHER_INFO_REQUEST_URL(CITY_ID)  [NSString stringWithFormat:@"http://flash.weather.com.cn/sk2/%@.xml",CITY_ID]

typedef void(^ResponseSuccessBlock)(id responseResult);
typedef void(^ResponseFailedBlock)(id responseResult);

#define PM25_REQUEST_URL(cityname) [NSString stringWithFormat:@"http://www.pm25.in/api/querys/pm2_5.json?city=%@&token=5j1znBVAsnSf5xQyNQyq",cityname]

#define kScreenSizeOfWidth   CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenSizeOfHeight  CGRectGetHeight([UIScreen mainScreen].bounds)

#define kScrollNotification @"ScrollNotification"
#define kShowFahrenheitTemNotification @"ShowFahrenheitTemNotification"
#define kUpdateConstellationNotification @"UpdateConstellationNotification"

#define kAppDatabaseName @"weatherapp.db"
#define kFirstLauch      @"firstlauch"
#define kBaiduMapKey     @"ttwhOTV0LHZvFlaxNGTEyc8g"
#define kShareSDKKey     @"6a7617ace58d"

#endif
