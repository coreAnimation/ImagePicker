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
#import "JRBrowerBottomView.h"
#import "JRBrowerHeaderView.h"
#import "JRAlbumManager.h"

@interface JRBrowerController () <UICollectionViewDataSource, UICollectionViewDelegate,
								JRBrowerHeaderViewDelegate>

///
@property (nonatomic, strong) UICollectionView			*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*flowLayout;

@property (nonatomic, strong) NSArray<JRAsset *>		*assetList;

@property (nonatomic, assign) NSInteger					index;

@property (nonatomic, strong) JRBrowerBottomView		*bottomView;

@property (nonatomic, strong) JRBrowerHeaderView		*headerView;

@property (nonatomic, strong) NSMutableArray<JRAsset *>	*backList;

@end

@implementation JRBrowerController

+ (instancetype)browerController:(NSArray<JRAsset *>*)assetList currentIndex:(NSInteger)index {
	
	JRBrowerController *browerVC = [JRBrowerController new];
	
	browerVC.assetList = assetList;
	browerVC.backList = [[JRAlbumManager sharedAlbumManager].selectedItem mutableCopy];
	browerVC.index = index;
	
	[browerVC setupView];
	
	return browerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
	[JRAlbumManager sharedAlbumManager].selectedItem = [self.backList mutableCopy];
}

- (void)backAction {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setupView {
	
	///
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
	
	///
	self.headerView = [JRBrowerHeaderView browerHeaderView];
	[self.headerView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	self.headerView.delegate = self;
	[self.view addSubview:self.headerView];
	
	///
	self.bottomView = [JRBrowerBottomView browerBottomView];
//	[self.headerView.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.bottomView];
	
	
	///
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];
	[self.collectionView addGestureRecognizer:tap];
}

/// 选择处理
- (void)selectedAsset:(JRAsset *)asset selected:(BOOL)isSelected {

	
	NSLog(@"------  %zd", isSelected);
	/// 选中
	if (isSelected) {
		/// 添加
		if (![self.backList containsObject:asset]) {
			[self.backList addObject:asset];
		}
	}

	/// 删除
	else {
		if ([self.backList containsObject:asset]) {
			[self.backList removeObject:asset];
		}
	}
	
	///
	[self scrollViewDidScroll:self.collectionView];
//	if ([self.delegate respondsToSelector:@selector(selectAsset:isSelected:)]) {
//		[self.delegate selectAsset:asset isSelected:isSelected];
//	}
}

- (void)tapAct {
	self.headerView.appearance = !self.headerView.appearance;
	self.bottomView.appearance = !self.headerView.appearance;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	CGPoint point = CGPointMake(scrollView.contentOffset.x + self.collectionView.frame.size.width * 0.5,
								self.collectionView.frame.size.height * 0.5);
	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
	
	JRAsset *asset = self.assetList[indexPath.row];
	self.headerView.asset = asset;
	if ([self.backList containsObject:asset]) {
		NSInteger index = [self.backList indexOfObject:asset];
		self.headerView.isSelected = YES;
		self.headerView.index = index;
	} else {
		self.headerView.isSelected = NO;
	}
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
