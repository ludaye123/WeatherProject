//
//  BackGourndViewController.m
//  WBIOSApp
//
//  Created by LS on 4/10/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "BackGourndViewController.h"
#import "ConstellationCollectionViewCell.h"

@interface BackGourndViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_images;
}

@end

static NSString *const kBackGroundCellIdentifier = @"BackGroundCellIdentifier";

@implementation BackGourndViewController

+ (id)loadViewController
{
   BackGourndViewController *viewController = (BackGourndViewController *)[ToolUnit loadFromStoryboard:@"Main" className:NSStringFromClass([BackGourndViewController class])];
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ConstellationCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kBackGroundCellIdentifier];
    
    _images = [[NSMutableArray alloc] initWithObjects:@"bg1",@"bg2",@"bg3",@"bg4",@"bg5",@"bg6",@"bg7",@"bg8", nil];
    
    if([_comse fetchBackGroundImage].length > 0)
    {
        self.bgImageView.image = [UIImage imageNamed:[_comse fetchBackGroundImage]];
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
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConstellationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBackGroundCellIdentifier forIndexPath:indexPath];
    
    NSString *imageStr = [_images objectAtIndex:indexPath.row];
    cell.conImageView.image = [UIImage imageNamed:imageStr];
    cell.conNameLbl.text = @"";
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageStr = [_images objectAtIndex:indexPath.row];
    self.bgImageView.image = [UIImage imageNamed:imageStr];
    [_comse saveBackGrourdImage:imageStr];
}

@end
