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
#import "JRAlbumManager.h"
#import "JRCollectionView.h"
#import "JRSelectedView.h"
#import "JRBrowerController.h"

@interface JRImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate,
										JRImageCellDelegate, JRSelectedViewDelegate>

/// 图片列表
@property (nonatomic, strong) JRCollectionView	*collectionView;
/// 底部选择Bar
@property (nonatomic, strong) JRSelectedView	*bottomBar;
/// 布局
@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;
/// 选择开始索引
@property (nonatomic, strong) NSIndexPath 		*startIndexPath;
/// 选择结束索引
@property (nonatomic, strong) NSIndexPath 		*endIndexPath;
/// 当前要设置的选中状态
@property (nonatomic, assign) BOOL				selectStatus;
/// 选中备份列表
@property (nonatomic, strong) NSMutableArray	*backPathArray;

/// 移动定时器
@property (nonatomic, strong) NSTimer			*timer;
/// 移动速度
@property (nonatomic, assign) CGFloat			speed;

@property (nonatomic, strong) UIPanGestureRecognizer *tap;

@end

@implementation JRImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setupView];
}

/// 初始化界面
- (void)setupView {

	/// 资源列表
	CGRect frame = CGRectMake(0, 64, Screen_w, Screen_h - 64 - 40);
	self.collectionView = [[JRCollectionView alloc] initWithFrame:frame
											 collectionViewLayout:self.layout];
	[self.collectionView registerClass:[JRImageCell class] forCellWithReuseIdentifier:@"item"];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.dataSource 	 = self;
	self.collectionView.delegate 	 = self;
	self.collectionView.contentInset = UIEdgeInsetsMake(Margin_w, Margin_w, Margin_w, Margin_w);
	[self.view addSubview:self.collectionView];
	
	self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	
	/// 底部操作调
	self.bottomBar = [JRSelectedView selectedView];
	self.bottomBar.delegate = self;
	[self.view addSubview:self.bottomBar];
	
	/// 滑动手势
	UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self
																		  action:@selector(tapAct:)];
	tap.maximumNumberOfTouches = 1;
	[self.view addGestureRecognizer:tap];
	self.tap = tap;
	
	/// 选中集合
	self.backPathArray = [NSMutableArray array];
	UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"取消"
															   style:UIBarButtonItemStylePlain
															  target:self
															  action:@selector(finishAction)];
	self.navigationItem.rightBarButtonItem = finish;
}

/// 自动向下滑动
- (void)scrollAnimation:(BOOL)isTop {
	
	if (isTop) {
		self.speed = -0.2;
	} else {
		self.speed = 0.2;
	}
	
	if (self.timer) {
		return;
	}
	self.timer = [NSTimer timerWithTimeInterval:0.002
										 target:self
									   selector:@selector(scrollViewScrollAction)
									   userInfo:nil
										repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/// 关闭定时器
- (void)stopScrollAction {
	if (self.timer) {
		[self.timer invalidate];
		self.timer = nil;
	}
}

/// scrollView 自动滚动操作
- (void)scrollViewScrollAction {
	
	CGFloat offsetY = self.collectionView.contentOffset.y;
	CGFloat maxY = self.collectionView.contentSize.height - self.collectionView.frame.size.height;
	
	if (offsetY < maxY && offsetY >= 0) {
		CGPoint point = self.collectionView.contentOffset;
		point.y = point.y + self.speed;
		[self.collectionView setContentOffset:point animated:NO];
	} else {
		if (offsetY < 0) {
			CGPoint point = self.collectionView.contentOffset;
			point.y = 0;
			[self.collectionView setContentOffset:point animated:NO];
		}
		
		[self.timer invalidate];
		self.timer = nil;
	}
	
	[self tapAct:self.tap];
}

/// 选择图片手势
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
			
		case UIGestureRecognizerStateChanged: {
			tmpIndexPath = [self.collectionView indexPathForItemAtPoint:p];
			
			CGPoint offset = [gesture locationInView:self.view];
			if (offset.y < 85) {
				[self scrollAnimation:YES];
			} else
			if (offset.y > Screen_h - 55) {
				[self scrollAnimation:NO];
			} else {
				[self stopScrollAction];
			}
		}
			break;
		
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateEnded:
			self.startIndexPath = nil;
			self.endIndexPath   = nil;
			[self.backPathArray removeAllObjects];
			[self stopScrollAction];
			break;
		default:
			break;
	}
	
	[self selectAction:tmpIndexPath];
}

/// 选择操作
- (void)selectAction:(NSIndexPath *)tmpIndexPath {
	
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
		cell.asset.isSelected = !self.selectStatus;
		[self selectAsset:path asset:cell.asset isSelected:cell.isSelected];
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
		cell.asset.isSelected = cell.isSelected;
		[self selectAsset:path asset:cell.asset isSelected:cell.isSelected];
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
		}
		return tmpArray;
	} else {
		
		for (NSInteger row = startPath.row; row<=endPath.row; row++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:startPath.section];
			[tmpArray addObject:indexPath];
		}
		return tmpArray;
	}
}

#pragma mark - JRSelectedViewDelegate
- (void)selectedViewDidClicked:(UIButton *)sender {
	switch (sender.tag) {
			/// 预览图片
		case 1: {
			JRBrowerController *browerVC = [JRBrowerController browerController:[JRAlbumManager sharedAlbumManager].selectedItem
																   currentIndex:0];
			[self.navigationController pushViewController:browerVC animated:YES];
		}
			
			break;
		case 2:
			NSLog(@"-----2");
			break;
		case 3:
			NSLog(@"-----3");
			break;
			/// 完成
		case 4:
			[self.navigationController dismissViewControllerAnimated:YES completion:nil];
			break;
		default:
			break;
	}
}

#pragma makr -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.album.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
																		   forIndexPath:indexPath];
	cell.backgroundColor = [UIColor redColor];
	cell.asset 			 = self.album.assetList[indexPath.row];
	cell.delegate 		 = self;
	cell.indexPath 		 = indexPath;
	
	return cell;
}

/// 点击图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

	JRBrowerController *browerVC = [JRBrowerController browerController:self.album.assetList currentIndex:indexPath.row];
	[self.navigationController pushViewController:browerVC animated:YES];
}

#pragma mark - JRImageCellDelegate
/// 选择图片回调
- (void)selectAsset:(NSIndexPath *)indexPath asset:(JRAsset *)asset isSelected:(BOOL)selected {
	
	if (selected) {
		/// 选中操作
		if (![[JRAlbumManager sharedAlbumManager].selectedItem containsObject:asset]) {
			[[JRAlbumManager sharedAlbumManager].selectedItem addObject:asset];
			[[JRAlbumManager sharedAlbumManager].selectedIndexPaths addObject:indexPath];
		}
	} else {
		/// 删除操作
		if ([[JRAlbumManager sharedAlbumManager].selectedItem containsObject:asset]) {
			[[JRAlbumManager sharedAlbumManager].selectedItem removeObject:asset];
			[[JRAlbumManager sharedAlbumManager].selectedIndexPaths removeObject:indexPath];
		}
	}
	
	/// 设置底部选择条数量
	[self.bottomBar setSelectedNumber];
	
	/// 更新选择 序号
	[self.collectionView reloadItemsAtIndexPaths:[JRAlbumManager sharedAlbumManager].selectedIndexPaths];
	NSLog(@"===== %zd", [JRAlbumManager sharedAlbumManager].selectedIndexPaths.count);
}

- (void)setAlbum:(JRAlbum *)album {
	_album = album;

	/// 标题
	self.title = [NSString stringWithFormat:@"%@(%zd)", album.name, album.count];
	
	///
	if (album.assetList) {
		[self.collectionView reloadData];
		return;
	}
	
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

/// 完成操作
- (void)finishAction {
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
