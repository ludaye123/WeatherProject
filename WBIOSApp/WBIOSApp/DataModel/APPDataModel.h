//
//  APPDataModel.h
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface APPDataModel : BaseModel

@end


@interface CityModel : BaseModel<NSCoding>

@property (copy, nonatomic) NSString *cityID;
@property (copy, nonatomic) NSString *cityName;
//@property (copy, nonatomic) NSString *spellName;
@property (copy, nonatomic) NSString *provinceName;

@end



//date":"20150302","cityName":"深圳","areaID":"101280601","temp":"17℃","tempF":"62.6℉","wd":"东北风","ws":"2级","sd":"56%","time":"01:35","sm":"暂无实况

@interface RealTimeTemModel : BaseModel

@property (copy, nonatomic) NSString *date;      //日期
@property (copy, nonatomic) NSString *cityName;  //城市名
@property (copy, nonatomic) NSString *areaID;    //地区ID
@property (copy, nonatomic) NSString *temp;      //摄氏温度
@property (copy, nonatomic) NSString *tempF;     //华氏温度
@property (copy, nonatomic) NSString *wd;        //风向
@property (copy, nonatomic) NSString *ws;        //风速
@property (copy, nonatomic) NSString *sd;        //湿度
@property (copy, nonatomic) NSString *time;     //刷新时间
@property (copy, nonatomic) NSString *sm;

@end

@interface TemInfoModel : BaseModel

@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *cityid;
@property (copy, nonatomic) NSString *temp1;
@property (copy, nonatomic) NSString *temp2;

@property (copy, nonatomic) NSString *tempF1;
@property (copy, nonatomic) NSString *tempF2;
@property (copy, nonatomic) NSString *weather;

@end

@interface TemInfoDetailModel : BaseModel

@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *city_en;
@property (copy, nonatomic) NSString *date_y;
@property (copy, nonatomic) NSString *week;
@property (copy, nonatomic) NSString *fchh;
@property (copy, nonatomic) NSString *cityid;
@property (copy, nonatomic) NSString *temp1;
@property (copy, nonatomic) NSString *temp2;
@property (copy, nonatomic) NSString *temp3;
@property (copy, nonatomic) NSString *temp4;
@property (copy, nonatomic) NSString *temp5;
@property (copy, nonatomic) NSString *temp6;

@property (copy, nonatomic) NSString *tempF1;
@property (copy, nonatomic) NSString *tempF2;
@property (copy, nonatomic) NSString *tempF3;
@property (copy, nonatomic) NSString *tempF4;
@property (copy, nonatomic) NSString *tempF5;
@property (copy, nonatomic) NSString *tempF6;

@property (copy, nonatomic) NSString *weather1;
@property (copy, nonatomic) NSString *weather2;
@property (copy, nonatomic) NSString *weather3;
@property (copy, nonatomic) NSString *weather4;
@property (copy, nonatomic) NSString *weather5;
@property (copy, nonatomic) NSString *weather6;

@property (copy, nonatomic) NSString *img1;
@property (copy, nonatomic) NSString *img2;
@property (copy, nonatomic) NSString *img3;
@property (copy, nonatomic) NSString *img4;
@property (copy, nonatomic) NSString *img5;
@property (copy, nonatomic) NSString *img6;
@property (copy, nonatomic) NSString *img7;
@property (copy, nonatomic) NSString *img8;
@property (copy, nonatomic) NSString *img9;
@property (copy, nonatomic) NSString *img10;
@property (copy, nonatomic) NSString *img11;
@property (copy, nonatomic) NSString *img12;

@property (copy, nonatomic) NSString *img_single;

@property (copy, nonatomic) NSString *img_title1;
@property (copy, nonatomic) NSString *img_title2;
@property (copy, nonatomic) NSString *img_title3;
@property (copy, nonatomic) NSString *img_title4;
@property (copy, nonatomic) NSString *img_title5;
@property (copy, nonatomic) NSString *img_title6;
@property (copy, nonatomic) NSString *img_title7;
@property (copy, nonatomic) NSString *img_title8;
@property (copy, nonatomic) NSString *img_title9;
@property (copy, nonatomic) NSString *img_title10;
@property (copy, nonatomic) NSString *img_title11;
@property (copy, nonatomic) NSString *img_title12;

@property (copy, nonatomic) NSString *img_title_single;

@property (copy, nonatomic) NSString *wind1;
@property (copy, nonatomic) NSString *wind2;
@property (copy, nonatomic) NSString *wind3;
@property (copy, nonatomic) NSString *wind4;
@property (copy, nonatomic) NSString *wind5;
@property (copy, nonatomic) NSString *wind6;

@property (copy, nonatomic) NSString *fx1;
@property (copy, nonatomic) NSString *fx2;
//@property (copy, nonatomic) NSString *fx3;
//@property (copy, nonatomic) NSString *fx4;
//@property (copy, nonatomic) NSString *fx5;
//@property (copy, nonatomic) NSString *fx6;


@property (copy, nonatomic) NSString *fl1;
@property (copy, nonatomic) NSString *fl2;
@property (copy, nonatomic) NSString *fl3;
@property (copy, nonatomic) NSString *fl4;
@property (copy, nonatomic) NSString *fl5;
@property (copy, nonatomic) NSString *fl6;

@property (copy, nonatomic) NSString *index;       //今天穿衣指数
@property (copy, nonatomic) NSString *index_d;


@property (copy ,nonatomic) NSString *index48;
@property (copy, nonatomic) NSString *index48_d;

@property (copy, nonatomic) NSString *index_uv;    //紫外线
@property (copy, nonatomic) NSString *index48_uv; //48小时紫外线
@property (copy, nonatomic) NSString *index_xc;   //洗车
@property (copy, nonatomic) NSString *index_tr; //旅游
@property (copy, nonatomic) NSString *index_co; //舒适指数

@property (copy, nonatomic) NSString *st1;
@property (copy, nonatomic) NSString *st2;
@property (copy, nonatomic) NSString *st3;
@property (copy, nonatomic) NSString *st4;
@property (copy, nonatomic) NSString *st5;
@property (copy, nonatomic) NSString *st6;

@property (copy, nonatomic) NSString *index_cl;  //晨练
@property (copy, nonatomic) NSString *index_ls;  //晾晒
@property (copy, nonatomic) NSString *index_ag;  //过敏

@end

@interface PM25Model : BaseModel

@property (copy, nonatomic) NSString *aqi;
@property (copy, nonatomic) NSString *quality;

@end


//city":"深圳","city_en":"shenzhen","date_y":"2015年3月2日","date":"","week":"星期一","fchh":"08","cityid":"101280601","temp1":"21℃~17℃","temp2":"24℃~17℃","temp3":"20℃~15℃","temp4":"21℃~16℃","temp5":"22℃~17℃","temp6":"24℃~17℃","tempF1":"69.8℉~62.6℉","tempF2":"75.2℉~62.6℉","tempF3":"68℉~59℉","tempF4":"69.8℉~60.8℉","tempF5":"71.6℉~62.6℉","tempF6":"75.2℉~62.6℉","weather1":"多云转阴","weather2":"小雨","weather3":"阵雨","weather4":"小雨转阴","weather5":"阴转多云","weather6":"多云转阴","img1":"1","img2":"2","img3":"7","img4":"99","img5":"3","img6":"99","img7":"7","img8":"2","img9":"2","img10":"1","img11":"1","img12":"2","img_single":"1","img_title1":"多云","img_title2":"阴","img_title3":"小雨","img_title4":"小雨","img_title5":"阵雨","img_title6":"阵雨","img_title7":"小雨","img_title8":"阴","img_title9":"阴","img_title10":"多云","img_title11":"多云","img_title12":"阴","img_title_single":"多云","wind1":"微风","wind2":"微风","wind3":"微风","wind4":"微风","wind5":"微风","wind6":"微风","fx1":"微风","fx2":"微风","fl1":"小于3级","fl2":"小于3级","fl3":"小于3级","fl4":"小于3级","fl5":"小于3级","fl6":"小于3级","index":"较舒适","index_d":"建议着薄外套、开衫牛仔衫裤等服装。年老体弱者应适当添加衣物，宜着夹克衫、薄毛衣等。","index48":"","index48_d":"","index_uv":"最弱","index48_uv":"","index_xc":"较适宜","index_tr":"适宜","index_co":"舒适","st1":"21","st2":"16","st3":"24","st4":"17","st5":"19","st6":"15","index_cl":"适宜","index_ls":"适宜","index_ag":"极易发"}}


@interface IndexModel : BaseModel

@property (strong, nonatomic) UIImage *indexImage;
@property (strong, nonatomic) NSString *indexName;
@property (strong, nonatomic) NSString *index;

@end


@interface ConstellationModel : BaseModel

@property (strong, nonatomic) NSString *conname;
@property (strong, nonatomic) NSString *contype;
@property (strong, nonatomic) NSString *conimageName;

@end






