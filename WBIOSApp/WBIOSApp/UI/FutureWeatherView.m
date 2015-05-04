//
//  FutureWeatherView.m
//  WBIOSApp
//
//  Created by LS on 4/13/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "FutureWeatherView.h"
#import "FutureWeatherTableViewCell.h"

@interface FutureWeatherView () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_futureWeathers;
    NSArray *_weeks;
    NSDictionary *_weekDict;
}

@property (assign, nonatomic) BOOL isFahrenheitTem;

@end

static NSString *const kWeatherInfoTableViewCellIdenfifier = @"WeatherInfoTableViewCellIdenfifier";

@implementation FutureWeatherView

+ (id)loadView
{
    FutureWeatherView *view = (FutureWeatherView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FutureWeatherView class]) owner:nil options:nil] firstObject];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    return view;
}

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.contentInset = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0);
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0);
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FutureWeatherTableViewCell class]) bundle:nil] forCellReuseIdentifier:kWeatherInfoTableViewCellIdenfifier];
    
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0,kScreenSizeOfWidth-10.0, 21.0)];
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"  未来6天内天气信息";
    self.tableView.tableHeaderView = label;
    
    _futureWeathers = [[NSMutableArray alloc] init];
    _weekDict = @{@"星期一":@1,@"星期二":@2,@"星期三":@3,@"星期四":@4,@"星期五":@5,@"星期六":@6,@"星期日":@7};
    _weeks = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
}

- (void)updateFutureWeatherInfo:(TemInfoDetailModel *)temInfoDetailObjc
{
    NSMutableArray *weeks = [self getWeeks:temInfoDetailObjc.week];
    
    NSDictionary *dict1 = @{@"weekname":[weeks firstObject],@"temp":temInfoDetailObjc.temp1,@"tempF":temInfoDetailObjc.tempF1,@"weather":temInfoDetailObjc.weather2};
    NSDictionary *dict2 = @{@"weekname":[weeks objectAtIndex:1],@"temp":temInfoDetailObjc.temp2,@"tempF":temInfoDetailObjc.tempF2,@"weather":temInfoDetailObjc.weather2};
    NSDictionary *dict3 = @{@"weekname":[weeks objectAtIndex:2],@"temp":temInfoDetailObjc.temp3,@"tempF":temInfoDetailObjc.tempF3,@"weather":temInfoDetailObjc.weather3};
    NSDictionary *dict4 = @{@"weekname":[weeks objectAtIndex:3],@"temp":temInfoDetailObjc.temp4,@"tempF":temInfoDetailObjc.tempF4,@"weather":temInfoDetailObjc.weather4};
    NSDictionary *dict5 = @{@"weekname":[weeks objectAtIndex:4],@"temp":temInfoDetailObjc.temp5,@"tempF":temInfoDetailObjc.tempF5,@"weather":temInfoDetailObjc.weather5};
    NSDictionary *dict6 = @{@"weekname":[weeks lastObject],@"temp":temInfoDetailObjc.temp6,@"tempF":temInfoDetailObjc.tempF6,@"weather":temInfoDetailObjc.weather6};

    [_futureWeathers addObject:dict1];
    [_futureWeathers addObject:dict2];
    [_futureWeathers addObject:dict3];
    [_futureWeathers addObject:dict4];
    [_futureWeathers addObject:dict5];
    [_futureWeathers addObject:dict6];
    
    [self.tableView reloadData];
}

- (void)setFahrenheitTem:(BOOL)isFahrenheitTem
{
    self.isFahrenheitTem = isFahrenheitTem;
    [self.tableView reloadData];
}

- (NSMutableArray *)getWeeks:(NSString *)week
{
    NSMutableArray *weeks = [[NSMutableArray alloc] init];
    NSNumber *weekNumber = [_weekDict objectForKey:week];
    int temp = [weekNumber intValue];
    [weeks addObject:[_weeks objectAtIndex:temp-1]];
    
    for(int i = 0; i< 5;i++)
    {
        if(temp < 7)
        {
            temp++;
            [weeks addObject:[_weeks objectAtIndex:temp-1]];
        }
        else
        {
            temp = 1;
            [weeks addObject:[_weeks objectAtIndex:temp-1]];
        }
    }
    
    NSLog(@"%@",weeks);
    
    return weeks;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UITableViewDataSource && UITableViewDelgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _futureWeathers.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FutureWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWeatherInfoTableViewCellIdenfifier];
    cell.isFahrenheitTem = self.isFahrenheitTem;
    
    NSDictionary *dict = [_futureWeathers objectAtIndex:indexPath.row];
    [cell updateWeatherInfo:dict];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


@end
