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
	
	/// 调用选择
	if ([self.delegate respondsToSelector:@selector(selectAsset:asset:isSelected:)]) {
		[self.delegate selectAsset:self.indexPath asset:self.asset isSelected:sender.selected];
	}
	
	///
	self.isSelected = !self.isSelected;
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
	
	/// 设置选择状态
	self.isSelected = asset.isSelected;
}


@end
