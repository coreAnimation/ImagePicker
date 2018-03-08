//
//  PHImageManager+JRExtension.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <Photos/Photos.h>


@class JRAsset;
@interface PHImageManager (JRExtension)

/**
 获取资源内容

 @param asset 资源
 @param targetSize 尺寸
 @param accomplish 完成回调
 @return PHImageRequestID
 */
+ (PHImageRequestID)jr_imageForAsset:(PHAsset *)asset
						  targetSize:(CGSize)targetSize
					   accomplish:(void (^)(UIImage *result, NSDictionary *info))accomplish;


/**
 获取一组资源的大小

 @param photos 资源数组
 @param completion 完成回调
 */
+ (void)jr_getPhotosBytesWithArray:(NSArray<JRAsset*> *)photos
						completion:(void (^)(NSString *totalBytes))completion;

/**
 获取选中的图片的大小

 @param completion 完成回调
 */
+ (void)jr_getSelectedBytesCompletion:(void (^)(NSString *totalBytes))completion;

@end
