//
//  PHImageManager+JRExtension.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "PHImageManager+JRExtension.h"
#import <Photos/Photos.h>

@implementation PHImageManager (JRExtension)

///
+ (PHImageRequestID)jr_imageForAsset:(PHAsset *)asset
						  targetSize:(CGSize)targetSize
						  accomplish:(void (^)(UIImage *result, NSDictionary *info))accomplish {
	
	PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
	option.resizeMode = PHImageRequestOptionsResizeModeFast;
	
	PHImageRequestID reqId = [[PHImageManager defaultManager] requestImageForAsset:asset
																		targetSize:targetSize
																	   contentMode:PHImageContentModeAspectFill
																		   options:option
																	 resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
																		 accomplish(result, info);
																	 }];
	return reqId;
}

@end
