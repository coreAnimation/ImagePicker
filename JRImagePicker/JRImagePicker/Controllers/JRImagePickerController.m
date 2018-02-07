//
//  JRImagePickerController.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRImagePickerController.h"
#import "JRTestViewController.h"
#import <Photos/Photos.h>
#import "JRAlbum.h"
#import "Header.h"
#import "JRImageCell.h"
#import "JRAsset.h"
#import "JRCollectionView.h"

@interface JRImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate>
///
@property (nonatomic, strong) JRCollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;

//@property (nonatomic, strong) NSMutableArray			*assetList;

@property (nonatomic, strong) NSIndexPath 		*startIndexPath;

@property (nonatomic, strong) NSIndexPath 		*endIndexPath;

@property (nonatomic, assign) BOOL				selectStatus;

@property (nonatomic, strong) NSMutableArray	*backPathArray;

@property (nonatomic, assign) NSInteger			pathCount;

@end

@implementation JRImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setupView];
}

/// 初始化界面
- (void)setupView {
	
	self.collectionView = [[JRCollectionView alloc] initWithFrame:self.view.frame
											 collectionViewLayout:self.layout];
	[self.collectionView registerClass:[JRImageCell class] forCellWithReuseIdentifier:@"item"];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
	self.collectionView.contentInset = UIEdgeInsetsMake(Margin_w, Margin_w, Margin_w, Margin_w);
	[self.view addSubview:self.collectionView];
	
//	[self.collectionView.panGestureRecognizer addTarget:self action:@selector(tapAct:)];
	
	
	UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(tapAct:)];
	tap.maximumNumberOfTouches = 1;
	[self.view addGestureRecognizer:tap];
	
	self.backPathArray = [NSMutableArray array];
}

- (void)tapAct:(UIGestureRecognizer *)gesture {
	
	CGPoint p = [gesture locationInView:self.collectionView];
	
	NSIndexPath *tmpIndexPath = nil;
	
	switch (gesture.state) {
		case UIGestureRecognizerStateBegan: {
			[self.backPathArray removeAllObjects];
			self.startIndexPath = [self.collectionView indexPathForItemAtPoint:p];
			tmpIndexPath = self.startIndexPath;
			JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:self.startIndexPath];
			self.selectStatus = !cell.isSelected;
		}
			break;
			
		case UIGestureRecognizerStateChanged:
			tmpIndexPath = [self.collectionView indexPathForItemAtPoint:p];
			break;
		
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateEnded:
			self.startIndexPath = nil;
			self.endIndexPath   = nil;
//			self.backPathArray  = nil;
			[self.backPathArray removeAllObjects];
			break;
		default:
			break;
	}
	
	/// 为发生选择
	if ([self.endIndexPath isEqual:tmpIndexPath] || !tmpIndexPath) {
		return;
	}
	self.endIndexPath = tmpIndexPath;

	/// 获取所有选择的 item 索引数组
	NSArray *pathArray = [self indexPathList:self.startIndexPath endIndexPath:self.endIndexPath];
	
	/// 遍历已有的选择
	NSMutableArray *sub = [NSMutableArray array];
	for (NSIndexPath *path in self.backPathArray) {
		if (![pathArray containsObject:path]) {
			[sub addObject:path];
		}
	}

	for (NSIndexPath *path in sub) {
		JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:path];
		cell.isSelected = !self.selectStatus;
		[self.backPathArray removeObject:path];
	}
	
	
	/// 遍历所有选择 获取选择不同的部分
	for (NSIndexPath *path in pathArray) {
		JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:path];
		if (cell.isSelected != self.selectStatus) {
			[self.backPathArray addObject:path];
		}
	}
	
	/// 遍历选择不同的部分 设置选择状态为相同
	for (NSIndexPath *path in self.backPathArray) {
		JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:path];
		cell.isSelected = self.selectStatus;
	}
}

/// 是否相同
- (BOOL)isEqualArray:(NSArray *)array1 array2:(NSArray *)array2 {
	
	if (array1.count != array2.count) {
		return NO;
	}
	
	BOOL equal = YES;
	for (NSIndexPath *indexPath in array1) {
		if (![array2 containsObject:indexPath]) {
			equal = NO;
		}
	}
	return equal;
}


/// 获取 indexPath 列表
- (NSArray *)indexPathList:(NSIndexPath *)startPath endIndexPath:(NSIndexPath *)endPath {

	if (startPath == nil || endPath == nil) {
		return @[];
	}
	
	if (startPath.row == endPath.row) {
		return @[startPath];
	}
	
	NSMutableArray *tmpArray = [NSMutableArray array];
	if (startPath.row > endPath.row) {
		for (NSInteger row = endPath.row; row<=startPath.row; row++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:startPath.section];
			[tmpArray addObject:indexPath];
			
//			JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//			if (cell.isSelected != self.selectStatus) {
//				[tmpArray addObject:indexPath];
//			}
		}
		return tmpArray;
	} else {
		
		for (NSInteger row = startPath.row; row<=endPath.row; row++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:startPath.section];
			[tmpArray addObject:indexPath];

//			JRImageCell *cell = (JRImageCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//			if (cell.isSelected != self.selectStatus) {
//				[tmpArray addObject:indexPath];
//			}
		}
		return tmpArray;
	}
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.album.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
																		   forIndexPath:indexPath];
	cell.backgroundColor = [UIColor redColor];
	cell.asset = self.album.assetList[indexPath.row];
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageCell *cell = (JRImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
	
	cell.isSelected = !cell.isSelected;
}

- (void)setAlbum:(JRAlbum *)album {
	_album = album;

	self.title = album.name;
	
	///
	NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:album.count];

	///
	[album.fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		JRAsset *asset = [JRAsset new];
		asset.asset = obj;
		[tmpArray addObject:asset];
	}];

	///
	album.assetList = tmpArray;
	///
	[self.collectionView reloadData];
}

- (UICollectionViewFlowLayout *)layout {
	if (_layout) {
		return _layout;
	}
	
	_layout = [UICollectionViewFlowLayout new];
	_layout.minimumLineSpacing = Margin_w;
	_layout.minimumInteritemSpacing = Margin_w;
	NSInteger count = 4;
	CGFloat width = (Screen_w - Margin_w * 5) / count;
	_layout.itemSize = CGSizeMake(width, width);

	return _layout;
}

@end
