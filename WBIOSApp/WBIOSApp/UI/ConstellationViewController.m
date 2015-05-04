//
//  ConstellationViewController.m
//  WBIOSApp
//
//  Created by LS on 3/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "ConstellationViewController.h"
#import "ConstellationCollectionViewCell.h"

@interface ConstellationViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *_constellations;
}

@end

static NSString *const kConstellationCellIdentifier = @"ConstellationCellIdentifier";
static ConstellationCollectionViewCell *tempCell = nil;

@implementation ConstellationViewController

+ (id)loadViewController
{
    ConstellationViewController *viewController = (ConstellationViewController *)[ToolUnit loadFromStoryboard:@"Main" className:NSStringFromClass([ConstellationViewController class])];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _constellations = [[NSMutableArray alloc] init];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ConstellationCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kConstellationCellIdentifier];
    
    NSArray *array = [_comse fetchConstellationInfo];
    [_constellations addObjectsFromArray:array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([_comse fetchBackGroundImage].length > 0)
    {
        self.view.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:[_comse fetchBackGroundImage]]] colorWithAlphaComponent:0.5];
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
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

- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _constellations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConstellationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kConstellationCellIdentifier forIndexPath:indexPath];
    
    ConstellationModel *constellationObjc = [_constellations objectAtIndex:indexPath.row];
    [cell showConsellationInfo:constellationObjc];
    if([self.conname isEqualToString:constellationObjc.conname])
    {
        cell.selectImageView.hidden = NO;
        tempCell = cell;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConstellationCollectionViewCell *cell = (ConstellationCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if([tempCell isEqual:cell])
        return;
    tempCell.selectImageView.hidden = YES;
    cell.selectImageView.hidden = NO;
    tempCell = cell;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(constellationViewController:didFinishedSelect:)])
    {
        [self.delegate constellationViewController:self didFinishedSelect:[_constellations objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController  popViewControllerAnimated:YES];
}

@end
