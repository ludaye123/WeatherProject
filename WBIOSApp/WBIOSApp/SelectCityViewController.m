//
//  SelectCityViewController.m
//  WBIOSApp
//
//  Created by LS on 11/29/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "SelectCityViewController.h"
#import "CityViewController.h"

@interface SelectCityViewController () <UITableViewDataSource,UITableViewDelegate,CityViewControllerDelegate>
{
    NSMutableArray *_citys;
    BOOL _isUpdate;
}

@end

@implementation SelectCityViewController

- (void)loadView
{
    [super loadView];
    [self createNavigationBar];
    [self createBackHomeButton];
    [self createEditButtom];
    [self createTitleLblBy:@"管理城市"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.bgImgView.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]] colorWithAlphaComponent:0.5];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    self.tableView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
    
    _citys = [[NSMutableArray alloc] init];
    
    FMResultSet *resultSet = [_appdelegate.database executeQuery:@"select * from selectcitymodel"];
    while ([resultSet next]) {
        NSString *cityid = [resultSet objectForColumnName:@"cityid"];
        NSString *cityName = [resultSet objectForColumnName:@"cityname"];
        NSString *temInfo = [resultSet objectForColumnName:@"teminfo"];
        
        TemInfoDetailModel *tempInfoObjc = [[TemInfoDetailModel alloc] init];
        tempInfoObjc.cityid = cityid;
        tempInfoObjc.city = cityName;
        tempInfoObjc.temp1 = temInfo;
        
        [_citys addObject:tempInfoObjc];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([_comse fetchBackGroundImage].length > 0)
    {
        self.bgImgView.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:[_comse fetchBackGroundImage]]] colorWithAlphaComponent:0.5];
    }
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

- (void)addCityAction:(UIButton *)sender
{
    CityViewController *cityViewController = [[CityViewController alloc] initWithNibName:@"CityViewController" bundle:nil];
    cityViewController.delegate = self;
    [self.navigationController pushViewController:cityViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _citys.count;
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
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    
    TemInfoDetailModel *tempInfoObjc = [_citys objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tempInfoObjc.city;
    cell.detailTextLabel.text = tempInfoObjc.temp1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        TemInfoDetailModel *tempObjc = [_citys objectAtIndex:indexPath.row];
        [_appdelegate.database executeUpdate:@"delete from selectcitymodel where cityid = ?",tempObjc.cityid];

        [_citys removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        _isUpdate = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - CityViewControllerDelegate

- (void)cityViewController:(CityViewController *)viewController didSelectedCity:(CityModel *)cityObjc
{
    //城市代号
    NSString *cityID = cityObjc.cityID;
    NSLog(@"%@",cityID);
    _isUpdate = YES;
    [_combz fetchTemInfoDetailBy:WEATHER_REQUEST_URL_3(cityID) completionBlock:^(id responseResult) {
        
        NSError *__autoreleasing error;
        TemInfoDetailModel *tempInfoDetalObjc = [[TemInfoDetailModel alloc] initWithDictionary:responseResult error:&error];
        NSLog(@"%@",tempInfoDetalObjc);
        
        if(!error)
        {
            [_citys addObject:tempInfoDetalObjc];
            [_appdelegate.database executeUpdate:@"insert into selectcitymodel values(?,?,?)",cityID,tempInfoDetalObjc.city,tempInfoDetalObjc.temp1];
            [self.tableView reloadData];
        }
    } failedBlock:^(id responseResult) {
        
        NSLog(@"%@",responseResult);
    }];
}


#pragma mark - Button Events

- (void)backHomeAction:(UIButton *)sender
{
    [super backHomeAction:sender];
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectCityViewController:updateCityInfo:)])
    {
        [self.delegate selectCityViewController:self updateCityInfo:_isUpdate];
    }
}

@end
