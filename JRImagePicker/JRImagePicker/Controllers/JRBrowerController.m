//
//  JRBrowerController.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRBrowerController.h"
#import "JRBrowerCell.h"
#import "JRAsset.h"
#import "Header.h"

@interface JRBrowerController () <UICollectionViewDataSource, UICollectionViewDelegate>

///
@property (nonatomic, strong) UICollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*flowLayout;

@property (nonatomic, strong) NSArray<JRAsset *>	*assetList;

@property (nonatomic, assign) NSInteger				index;

@end

@implementation JRBrowerController

+ (instancetype)browerController:(NSArray<JRAsset *>*)assetList currentIndex:(NSInteger)index {
	
	JRBrowerController *browerVC = [JRBrowerController new];
	
	browerVC.assetList = assetList;
	browerVC.index = index;
	
	[browerVC setupView];
	
	return browerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
//	[self setupView];
}

- (void)setupView {
	
	self.collectionView = ({
		CGRect frame = CGRectMake(-15, 0, Screen_w + 30, Screen_h);
		UICollectionView *collView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.flowLayout];
		collView.delegate 	= self;
		collView.dataSource = self;
		collView.pagingEnabled = YES;
		[self.view addSubview:collView];
		[collView registerClass:[JRBrowerCell class] forCellWithReuseIdentifier:@"item"];
		collView;
	});
	
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
	[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

///
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRBrowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
	cell.asset = self.assetList[indexPath.row];

	return cell;
}


- (UICollectionViewFlowLayout *)flowLayout {
	if (_flowLayout) {
		return _flowLayout;
	}
	
	_flowLayout = [UICollectionViewFlowLayout new];
	_flowLayout.itemSize = CGSizeMake(Screen_w + 30, Screen_h);
	_flowLayout.minimumLineSpacing = 0;
	_flowLayout.minimumInteritemSpacing = 0;
	_flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	return _flowLayout;
}


@end
