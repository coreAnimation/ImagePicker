//
//  PHImageManager+JRExtension.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "PHImageManager+JRExtension.h"
#import <Photos/Photos.h>
#import "JRAsset.h"
#import "JRAlbumManager.h"

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

/// 获取一组资源原始大小
+ (void)jr_getPhotosBytesWithArray:(NSArray<JRAsset*> *)photos
						completion:(void (^)(NSString *totalBytes))completion {
	
	if (photos.count == 0) {
		completion(@"");
		return;
	}
	
	PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
	options.resizeMode = PHImageRequestOptionsResizeModeFast;
	
	__block NSUInteger dataLength = 0;
	__block NSInteger photoCount = 0;
	for (JRAsset *asset in photos) {
		[[PHImageManager defaultManager] requestImageDataForAsset:asset.asset
														  options:options
													resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
														if (imageData) {
															dataLength += imageData.length;
														}
														photoCount++;
														if (photoCount >= photos.count) {
															completion([self getBytesFromDataLength:dataLength]);
														}
		}];
	}
}

///
+ (void)jr_getSelectedBytesCompletion:(void (^)(NSString *totalBytes))completion {
	
	[self jr_getPhotosBytesWithArray:[JRAlbumManager sharedAlbumManager].selectedItem completion:^(NSString *totalBytes) {
		completion(totalBytes);
	}];
	
}


/// 单位转换
+ (NSString *)getBytesFromDataLength:(NSInteger)dataLength {
	NSString *bytes;
	if (dataLength >= 0.1 * (1024 * 1024)) {
		bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
	} else if (dataLength >= 1024) {
		bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
	} else {
		bytes = [NSString stringWithFormat:@"%zdB",dataLength];
	}
	return bytes;
}



@end
