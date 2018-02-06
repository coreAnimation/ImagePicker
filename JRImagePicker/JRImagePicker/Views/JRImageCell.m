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
#import "PHImageManager+JRExtension.h"

@interface JRImageCell ()

@property (nonatomic, strong) UIImageView	*imgView;

@property (nonatomic, strong) UIView		*selectedView;

@end

@implementation JRImageCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setupView];
	return self;
}

/// 初始化界面
- (void)setupView {
	
	self.imgView = [UIImageView new];
	self.imgView.backgroundColor = [UIColor yellowColor];
	self.imgView.contentMode = UIViewContentModeScaleAspectFill;
	self.imgView.clipsToBounds = YES;
	[self.contentView addSubview:self.imgView];
	
	self.selectedView = [UIView new];
	self.selectedView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
	[self.contentView addSubview:self.selectedView];
	
	self.selectedView.hidden = YES;
}

/// 布局
- (void)layoutSubviews {
	[super layoutSubviews];
	
	///
	self.imgView.frame = self.contentView.bounds;
	self.selectedView.frame = self.contentView.bounds;
}

///
- (void)setIsSelected:(BOOL)isSelected {
	_isSelected = isSelected;
	
	self.selectedView.hidden = !isSelected;
	self.asset.isSelected = isSelected;
}

- (void)setAsset:(JRAsset *)asset {
	_asset = asset;
	
	PHAsset *phAsset = asset.asset;
	
	CGFloat sizeW = (Screen_w - Margin_w * 5) / (CGFloat)4 * [UIScreen mainScreen].scale;
	CGFloat aspectRatio = phAsset.pixelHeight / (CGFloat)phAsset.pixelWidth;
	
	if (asset) {
		
		CGSize imageSize = CGSizeMake(sizeW, sizeW);
		/// 宽图片
		if (asset.pixelWidth > asset.pixelHeight) {
			CGFloat w = sizeW / aspectRatio;
			imageSize = CGSizeMake(w, sizeW);
		}
		/// 高图片
		else {
			CGFloat h = sizeW * aspectRatio;
			imageSize = CGSizeMake(sizeW, h);
		}

		/// 获取图片
		[PHImageManager jr_imageForAsset:phAsset
							  targetSize:imageSize
							  accomplish:^(UIImage *result, NSDictionary *info) {
								  if (result) { self.imgView.image = result; }
		}];
	}
	
	
	self.selectedView.hidden = !asset.isSelected;
}


@end
