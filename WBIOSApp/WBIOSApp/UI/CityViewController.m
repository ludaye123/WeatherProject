//
//  CityViewController.m
//  WBIOSApp
//
//  Created by LS on 11/29/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "CityViewController.h"
#import "CityCollectionViewCell.h"
#import "FMDatabase.h"

@interface CityViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *_hotCitys;
    NSMutableArray *_searchCitys;
}

@end

static NSString *const kCityCollectionViewCellIdentifier = @"CityCollectionViewCellIdentifier";
static NSString *const kSearchCityTableViewCellIdentfier = @"SearchCityTableViewCellIdentfier";

@implementation CityViewController

- (void)loadView
{
    [super loadView];
    [self createNavigationBar];
//    [self createBackHomeButton];
    [self createCalcelButton];
    [self createSearchViewBy:@"请输入地区的名称或邮编"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view bringSubviewToFront:self.collectionView];
    
    self.bgImgView.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]]colorWithAlphaComponent:0.3];
        
    NSString *hotCityPath = [[NSBundle mainBundle] pathForResource:@"hotcity" ofType:@"plist"];
    _hotCitys = [NSArray arrayWithContentsOfFile:hotCityPath];
    _searchCitys = [[NSMutableArray alloc] init];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CityCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:kCityCollectionViewCellIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSearchCityTableViewCellIdentfier];
    self.tableView.contentInset = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    self.tableView.hidden = YES;
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

- (void)cancelAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",string);
    [self showSearchResult:textField];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self showSearchResult:textField];
}

- (void)showSearchResult:(UITextField *)textField
{
    NSString *text = textField.text;
    if(text)
    {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from citymodel where cityname like '%@%%'",text];
        FMResultSet *resultSet = [_appdelegate.database executeQuery:sqlStr];
        [_searchCitys removeAllObjects];
        while ([resultSet next]) {
            NSString *cityid = [resultSet objectForColumnIndex:0];
            NSString *cityname = [resultSet objectForColumnIndex:1];
            NSString *provice = [resultSet objectForColumnIndex:2];
            CityModel *cityObjc = [[CityModel alloc] init];
            cityObjc.cityID = cityid;
            cityObjc.cityName = cityname;
            cityObjc.provinceName = provice;
            
            [_searchCitys addObject:cityObjc];
        }
        self.tableView.hidden = NO;
        self.collectionView.hidden = YES;
        [self.tableView reloadData];
    }
    else
    {
        self.collectionView.hidden = NO;
        self.tableView.hidden = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _hotCitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCityCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.cityNameLbl.text = [_hotCitys objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSString *cityName =[_hotCitys objectAtIndex:indexPath.row];
    FMResultSet *result = [_appdelegate.database executeQuery:@"select * from citymodel where cityName = ?",cityName];
    
    CityModel *cityObjc = [[CityModel alloc] init];
    
    while ([result next]) {
     
        cityObjc.cityID = [result objectForColumnIndex:0];
        cityObjc.cityName = [result objectForColumnIndex:1];
        cityObjc.provinceName = [result objectForColumnIndex:2];
    }
    
//    while ([result next]) {
//        NSString *temp = [result objectForColumnIndex:0];
//        NSLog(@"%@",temp);
//    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(cityViewController:didSelectedCity:)])
    {
        [self.delegate cityViewController:self didSelectedCity:cityObjc];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchCitys.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCityTableViewCellIdentfier];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    CityModel *cityObjc = [_searchCitys objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@,中国",cityObjc.provinceName,cityObjc.cityName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    CityModel *cityid = [_searchCitys objectAtIndex:indexPath.row];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(cityViewController:didSelectedCity:)])
    {
        [self.delegate cityViewController:self didSelectedCity:cityid];
    }
}

@end
