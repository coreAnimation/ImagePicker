//
//  JRAsset.m
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/7.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRAsset.h"
#import "Header.h"
#import "PHImageManager+JRExtension.h"

@implementation JRAsset

- (UIImage *)thumbImage {
	if (_thumbImage) {
		return _thumbImage;
	}
	
	/// 获取 占位图
	[self setThumbImageAccomplist:^(UIImage *result, NSDictionary *info) {
		if (result) { _thumbImage = result; }
	}];

	return _thumbImage;
}

///
- (void)setThumbImageAccomplist:(void (^)(UIImage *result, NSDictionary *info))accomplish {
	
	if (_thumbImage) {
		accomplish(_thumbImage, nil);
	}
	
	PHAsset *phAsset = self.asset;
	CGFloat sizeW = (Screen_w - Margin_w * 5) / (CGFloat)4 * [UIScreen mainScreen].scale;
	CGFloat aspectRatio = phAsset.pixelHeight / (CGFloat)phAsset.pixelWidth;
	
	if (phAsset) {
		
		CGSize imageSize = CGSizeMake(sizeW, sizeW);
		/// 宽图片
		if (self.asset.pixelWidth > self.asset.pixelHeight) {
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
								  accomplish(result, info);
							  }];
	}
}

///
- (void)getSoucreImage:(void (^)(UIImage *result, NSDictionary *info))accomplish {
	
	if (_sourceImage) {
		accomplish(_sourceImage, nil);
	}
	PHAsset *phAsset = self.asset;

	if (phAsset) {
		
		CGSize imageSize = CGSizeMake(self.asset.pixelHeight, self.asset.pixelWidth);
		/// 获取图片
		[PHImageManager jr_imageForAsset:phAsset
							  targetSize:imageSize
							  accomplish:^(UIImage *result, NSDictionary *info) {
								  accomplish(result, info);
								  NSLog(@"======= %@", [NSThread currentThread]);
							  }];
	}
}

#pragma mark - Equal 方法
- (BOOL)isEqual:(id)other
{
	if (other == self) {
		return YES;
	}
	if ([self class] != [other class]) {
		return NO;
	}
	
	if ([other isKindOfClass:[JRAsset class]]) {
		JRAsset *asset= (JRAsset *)other;
		return [self.asset isEqual:asset.asset];
	} else {
		return NO;
	}
}

- (NSUInteger)hash
{
	return [self.asset hash];
}

@end
