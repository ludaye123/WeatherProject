//
//  RightViewController.m
//  WBIOSApp
//
//  Created by LS on 11/6/14.
//  Copyright (c) 2014 lushen. All rights reserved.
//

#import "RightViewController.h"
#import "ConstellationViewController.h"
#import "BackGourndViewController.h"
#import "MainViewController.h"

@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate,ConstellationViewControllerDelegate>

@end

@implementation RightViewController


+ (id)loadViewController
{
    RightViewController *viewController = (RightViewController *)[ToolUnit loadFromStoryboard:@"Main" className:NSStringFromClass([RightViewController class])];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(50, 50, 50);
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGRect frame = self.tableView.frame;
    frame.size.width = width - 50;
    self.tableView.frame =frame;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImage *accessImage = [UIImage imageNamed:@"setting_arrow@2x~iphone.png"];
    UIImageView *accessImageView = [[UIImageView alloc] initWithFrame:CGRectMake(239.0, 9.0, accessImage.size.width, accessImage.size.height)];
    accessImageView.image = accessImage;
    
    UISwitch *customSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(214.0, 6.5, 51, 31)];
    [customSwitch addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"setting_unit@2x~iphone.png"];
            cell.textLabel.text = @"显示华氏";
            customSwitch.tag = 100;
            [cell.contentView addSubview:customSwitch];
            break;
            
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"setting_theme@2x~iphone.png"];
            cell.textLabel.text = @"更换主题";
            [cell.contentView addSubview:accessImageView];

            break;
            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"setting_characters@2x~iphone.png"];
            cell.textLabel.text = @"星座精灵";
            [cell.contentView addSubview:accessImageView];
            break;
            
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"setting_weibo@2x~iphone.png"];
            cell.textLabel.text = @"微博授权";
            customSwitch.tag = 101;
            [cell.contentView addSubview:customSwitch];
            break;
            
        default:
            break;
    }
        
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, -10.0, tableView.bounds.size.width, 44)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor blackColor];
    label.text = @"\n  更多设置";
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        BackGourndViewController *backgroundViewController = [BackGourndViewController loadViewController];
        [_appdelegate.container.navigationController pushViewController:backgroundViewController animated:YES];
    }
    else if(indexPath.row == 2)
    {
        ConstellationViewController *viewController = [ConstellationViewController loadViewController];
         UINavigationController *navigation = _appdelegate.container.centerViewController;
//        viewController.delegate = self;
        MainViewController *mainViewController = (MainViewController *)navigation.topViewController;
        viewController.delegate = mainViewController;
        viewController.conname = [_comse fetchConname];
        [_appdelegate.container.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - Button Events

- (void)changeAction:(UISwitch *)sender
{
    if(sender.tag == 100)
    {
        NSDictionary *dict = @{@"state":[sender isOn]?@1:@0};
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowFahrenheitTemNotification object:dict];
        [self closeSideMenu];
    }
    else
    {
        
    }
}

- (void)constellationViewController:(ConstellationViewController *)viewController didFinishedSelect:(ConstellationModel *)tempObjc
{
//    [self performSelectorOnMainThread:@selector(updateConsellation:) withObject:tempObjc waitUntilDone:NO];
    [self updateConsellation:tempObjc];
}

- (void)updateConsellation:(ConstellationModel *)tempObjc
{
    [self closeSideMenu];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateConstellationNotification object:tempObjc];
}

@end
