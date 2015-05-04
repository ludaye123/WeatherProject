//
//  LifeHelpView.m
//  WBIOSApp
//
//  Created by LS on 3/2/15.
//  Copyright (c) 2015 lushen. All rights reserved.
//

#import "LifeHelpView.h"
#import "IndexCollectionViewCell.h"

@interface LifeHelpView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *_indexImages;
    NSArray *_indexNames;
    NSArray *_indexs;
    
    NSMutableArray *_showIndexs;
}

@end


static NSString *const kIndexCollectionViewCellIdentifier = @"IndexCollectionViewCellIdentifier";

@implementation LifeHelpView

+ (id)loadView
{
    LifeHelpView *lifeView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LifeHelpView class]) owner:self options:nil] firstObject];
//    [lifeView setDelegate];
    
    return lifeView;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([IndexCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kIndexCollectionViewCellIdentifier];
    self.collectionView.scrollEnabled = NO;
    
    UIImage *uvImage = [UIImage imageNamed:@"index_uv@2x~iphone"];
    UIImage *dressImage = [UIImage imageNamed:@"index_dressing@2x~iphone"];
    UIImage *travleImage = [UIImage imageNamed:@"index_travle@2x~iphone"];
    UIImage *carImage = [UIImage imageNamed:@"index_carwash@2x~iphone"];
    UIImage *dryImage  = [UIImage imageNamed:@"index_drying@2x~iphone"];
    UIImage *sportImage = [UIImage imageNamed:@"index_morning@2x~iphone"];
    UIImage *comfortImage = [UIImage imageNamed:@"index_comfort@2x~iphone"];
    
    _indexImages = [NSArray arrayWithObjects:uvImage,dressImage,travleImage,carImage,dryImage,sportImage,comfortImage, nil];
    _indexNames = [NSArray arrayWithObjects:@"【紫外线】",@"【穿衣】",@"【旅游】",@"【洗车】",@"【晾晒】",@"【运动】",@"【舒适度】", nil];
    _showIndexs = [[NSMutableArray alloc] init];
}


//- (void)setDelegate
//{
//    self.backgroundColor = [UIColor clearColor];
//    self.collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([IndexCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kIndexCollectionViewCellIdentifier];
//    
//    UIImage *uvImage = [UIImage imageNamed:@"index_uv@2x~iphone"];
//    UIImage *dressImage = [UIImage imageNamed:@"index_dressing@2x~iphone"];
//    UIImage *travleImage = [UIImage imageNamed:@"index_travle@2x~iphone"];
//    UIImage *carImage = [UIImage imageNamed:@"index_carwash@2x~iphone"];
//    UIImage *dryImage  = [UIImage imageNamed:@"index_drying@2x~iphone"];
//    UIImage *sportImage = [UIImage imageNamed:@"index_morning@2x~iphone"];
//    UIImage *comfortImage = [UIImage imageNamed:@"index_comfort@2x~iphone"];
//
//    _indexImages = [NSArray arrayWithObjects:uvImage,dressImage,travleImage,carImage,dryImage,sportImage,comfortImage, nil];
//    _indexNames = [NSArray arrayWithObjects:@"【紫外线】",@"【穿衣】",@"【旅游】",@"【洗车】",@"【晾晒】",@"【运动】",@"【舒适度】", nil];
//    _showIndexs = [[NSMutableArray alloc] init];
//}

- (void)updateContentForCell:(id)contents
{
    TemInfoDetailModel *temInfoDetailObjc = (TemInfoDetailModel *)contents;
    _indexs = @[temInfoDetailObjc.index_uv,temInfoDetailObjc.index,temInfoDetailObjc.index_tr,temInfoDetailObjc.index_xc,temInfoDetailObjc.index_ls,temInfoDetailObjc.index_cl,temInfoDetailObjc.index_co];
    
    for(int i = 0; i < _indexs.count;i++)
    {
        IndexModel *indexObjc = [[IndexModel alloc] init];
        indexObjc.indexImage = [_indexImages objectAtIndex:i];
        indexObjc.indexName = [_indexNames objectAtIndex:i];
        indexObjc.index = [_indexs objectAtIndex:i];
        [_showIndexs addObject:indexObjc];
    }
    
    [self.collectionView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _showIndexs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIndexCollectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell updateContentInfo:[_showIndexs objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (kScreenSizeOfWidth - 30) / 2;
    return CGSizeMake(width, width);
}

@end
