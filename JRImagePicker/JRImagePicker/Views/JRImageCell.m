//
//  JRImageCell.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRImageCell.h"
#import <Photos/Photos.h>
#import "Header.h"
#import "JRAsset.h"
#import "JRSelectedButton.h"
#import "PHImageManager+JRExtension.h"
#import "JRAlbumManager.h"

@interface JRImageCell ()

/// 图片
@property (nonatomic, strong) UIImageView	*imgView;
/// 选中遮罩
@property (nonatomic, strong) UIView		*selectedView;
/// 选择按钮
@property (nonatomic, strong) JRSelectedButton	*selButton;

@end

@implementation JRImageCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setupView];
	return self;
}

/// 初始化界面
- (void)setupView {
	
	/// 选中图片
	self.imgView = [UIImageView new];
	self.imgView.backgroundColor = [UIColor yellowColor];
	self.imgView.contentMode = UIViewContentModeScaleAspectFill;
	self.imgView.clipsToBounds = YES;
	[self.contentView addSubview:self.imgView];
	
	/// 选择遮罩
	self.selectedView = [UIView new];
	self.selectedView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
	[self.contentView addSubview:self.selectedView];
	self.selectedView.hidden = YES;
	
	/// 选择按钮
	self.selButton = [[JRSelectedButton alloc] init];
//	self.selButton.backgroundColor = [UIColor orangeColor];
	[self.contentView addSubview:self.selButton];
	[self.selButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
}

/// 选中按钮事件
- (void)selectAction:(UIButton *)sender {
	
	/// 设置选中状态
	self.isSelected = !self.isSelected;
	
	/// 调用选择
	if ([self.delegate respondsToSelector:@selector(selectAsset:asset:isSelected:)]) {
		[self.delegate selectAsset:self.indexPath asset:self.asset isSelected:sender.selected];
	}
}

/// 布局
- (void)layoutSubviews {
	[super layoutSubviews];
	
	/// 图片
	self.imgView.frame = self.contentView.bounds;
	/// 遮罩
	self.selectedView.frame = self.contentView.bounds;
	/// 选择按钮
	CGFloat width = self.contentView.bounds.size.width;
	CGFloat w = 40;
	
	self.selButton.frame = CGRectMake(width - w, 0, w, w);
}

/// 设置选中状态
- (void)setIsSelected:(BOOL)isSelected {
	_isSelected = isSelected;
	
	self.selectedView.hidden = !isSelected;
	self.asset.isSelected = isSelected;
	
	self.selButton.selected = isSelected;
}

- (void)setTmpSelected:(BOOL)tmpSelected {
	_tmpSelected = tmpSelected;
	
	if (tmpSelected) {
		self.isSelected = YES;
	} else {
		self.isSelected = self.isSelected;
	}
}

// 设置多媒体资源
- (void)setAsset:(JRAsset *)asset {
	_asset = asset;

	[asset setThumbImageAccomplist:^(UIImage *result, NSDictionary *info) {
		if (result) { self.imgView.image = result; }
	}];
	
	/// 设置选择状态
	self.isSelected = asset.isSelected;
	

	for (NSInteger i=0; i<[JRAlbumManager sharedAlbumManager].selectedItem.count; i++) {
		JRAsset *myAsset = [JRAlbumManager sharedAlbumManager].selectedItem[i];
		
		NSLog(@"%@ = %@", myAsset.asset.localIdentifier, asset.asset.localIdentifier);
		
		if ([myAsset.asset.localIdentifier isEqualToString:asset.asset.localIdentifier]) {
			
			self.isSelected = YES;
			self.selButton.number = i + 1;
			break;
		}
	}
	
	
//	NSInteger index = [[JRAlbumManager sharedAlbumManager].selectedItem indexOfObject:asset];
//	if (index != NSNotFound) {
//		self.selButton.number = index + 1;
//	} else {
//
//		for (NSInteger i=0; i<[JRAlbumManager sharedAlbumManager].selectedItem.count; i++) {
//			JRAsset *myAsset = [JRAlbumManager sharedAlbumManager].selectedItem[i];
//
//			NSLog(@"%@ = %@", myAsset.asset.localIdentifier, asset.asset.localIdentifier);
//
//			if ([myAsset.asset.localIdentifier isEqualToString:asset.asset.localIdentifier]) {
//
//				self.isSelected = YES;
//				self.selButton.number = i + 1;
//				break;
//			}
//		}
//	}
}


@end
