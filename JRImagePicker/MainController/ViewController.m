//
//  ViewController.m
//  JRImagePicker
//
//  Created by 王潇 on 2017/12/9.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "ViewController.h"
#import "JRImagePickerController.h"
#import <Photos/Photos.h>
#import "JRAlbumManager.h"
#import "JRAlbum.h"
#import "JRImageListController.h"
#import "Header.h"
#import "JRPickerViewController.h"
#import "JRImageCell.h"

@interface ViewController () <JRImageListControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView	*collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;

@property (nonatomic, strong) NSArray<JRAsset *>			*imageList;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *selImage = [[UIButton alloc] initWithFrame:CGRectMake(40, 80, Screen_w - 80, 40)];
	[selImage setTitle:@"打开相册" forState:UIControlStateNormal];
	selImage.backgroundColor = [UIColor orangeColor];
	[self.view addSubview:selImage];
	
	[selImage addTarget:self
				 action:@selector(openPicker)
	   forControlEvents:UIControlEventTouchUpInside];
	
	
	///
	CGRect frame = CGRectMake(0, 180, Screen_w, Screen_w);
	self.collectionView = [[UICollectionView alloc] initWithFrame:frame
											 collectionViewLayout:self.layout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.collectionView];
	[self.collectionView registerClass:[JRImageCell class] forCellWithReuseIdentifier:@"cc"];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	JRImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cc" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor orangeColor];
	cell.asset = self.imageList[indexPath.row];
	
	return cell;
}

/// 打开相册
- (void)openPicker {

	JRPickerViewController *picVC = [JRPickerViewController pickerViewController];
	picVC.delegate = self;
	[self presentViewController:picVC animated:YES completion:nil];
	
//	UINavigationController *list = [JRImageListController imageListController];
//	[self presentViewController:list animated:YES completion:nil];
}

- (void)imageListController:(JRImageListController *)imageListControler
		finishPickingPhotos:(NSArray<JRAsset *> *)assets
	ifSelectedOriginalPhoto:(BOOL)isSelectOriginalPhoto {
	NSLog(@"======= %zd", assets.count);
	self.imageList = assets.copy;
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
