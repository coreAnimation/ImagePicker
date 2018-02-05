//
//  PHImageManager+JRExtension.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHImageManager (JRExtension)

//- (PHImageRequestID)requestImageForAsset:(PHAsset *)asset
//							  targetSize:(CGSize)targetSize
//							 contentMode:(PHImageContentMode)contentMode
//								 options:(nullable PHImageRequestOptions *)options
//						   resultHandler:(void (^)(UIImage *__nullable result, NSDictionary *__nullable info))resultHandler;

+ (PHImageRequestID)jr_imageForAsset:(PHAsset *)asset
						  targetSize:(CGSize)targetSize
					   accomplish:(void (^)(UIImage *result, NSDictionary *info))accomplish;


@end
