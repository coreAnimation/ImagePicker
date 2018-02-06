//
//  PHImageManager+JRExtension.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHImageManager (JRExtension)

+ (PHImageRequestID)jr_imageForAsset:(PHAsset *)asset
						  targetSize:(CGSize)targetSize
					   accomplish:(void (^)(UIImage *result, NSDictionary *info))accomplish;


@end
