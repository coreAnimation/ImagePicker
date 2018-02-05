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

@interface JRImagePickerController () <UICollectionViewDataSource>
///
@property (nonatomic, strong) UICollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;

@property (nonatomic, strong) NSMutableArray			*assetList;

@end

@implementation JRImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self setupView];
}

/// 初始化界面
- (void)setupView {
	
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
											 collectionViewLayout:self.layout];
	[self.collectionView registerClass:[JRImageCell class] forCellWithReuseIdentifier:@"item"];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.dataSource = self;
	self.collectionView.contentInset = UIEdgeInsetsMake(Margin_w, Margin_w, Margin_w, Margin_w);
	[self.view addSubview:self.collectionView];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item"
																		   forIndexPath:indexPath];
	cell.backgroundColor = [UIColor redColor];
	cell.asset = self.assetList[indexPath.row];
	
	return cell;
}

- (void)setAlbum:(JRAlbum *)album {
	_album = album;

	self.title = album.name;
	
	///
	self.assetList = [NSMutableArray arrayWithCapacity:album.count];
	
	///
	[album.fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[self.assetList addObject:obj];
	}];

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
