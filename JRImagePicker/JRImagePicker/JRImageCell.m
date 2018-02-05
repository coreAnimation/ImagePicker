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

@interface JRImageCell ()

@property (nonatomic, strong) UIImageView	*imgView;

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
}

/// 布局
- (void)layoutSubviews {
	[super layoutSubviews];
	
	///
	self.imgView.frame = self.contentView.bounds;
}

- (void)setAsset:(PHAsset *)asset {
	_asset = asset;
	
	CGFloat sizeW = (Screen_w - Margin_w * 5) / (CGFloat)4 * [UIScreen mainScreen].scale;
	
	if (asset) {
		
		CGSize imageSize = CGSizeMake(sizeW, sizeW);
		/// 宽图片
		if (asset.pixelWidth > asset.pixelHeight) {
			CGFloat aspectRatio = asset.pixelHeight / (CGFloat)asset.pixelWidth;
			CGFloat w = sizeW / aspectRatio;
			imageSize = CGSizeMake(w, sizeW);
			NSLog(@"--- %@ -- %f", NSStringFromCGSize(imageSize), aspectRatio);
		}
		/// 高图片
		else {
			CGFloat aspectRatio = asset.pixelHeight / (CGFloat)asset.pixelWidth;
			CGFloat h = sizeW * aspectRatio;
			imageSize = CGSizeMake(sizeW, h);
			NSLog(@"==== %@ -- %f", NSStringFromCGSize(imageSize), aspectRatio);
		}

		PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
		option.resizeMode = PHImageRequestOptionsResizeModeFast;
		
		[[PHImageManager defaultManager] requestImageForAsset:asset
												   targetSize:imageSize//CGSizeMake(200, 200)
												  contentMode:PHImageContentModeAspectFill
													  options:option
												resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
													if (result) {
														self.imgView.image = result;
													}
												}];
	}
	
}


@end
