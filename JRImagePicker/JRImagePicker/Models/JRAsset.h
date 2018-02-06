//
//  JRAsset.h
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/7.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <Photos/Photos.h>

@class PHAsset;
@interface JRAsset : PHAsset

/**
 是否被选择
 */
@property (nonatomic, assign) BOOL	isSelected;

/**
 多媒体资源对象
 */
@property (nonatomic, strong) PHAsset	*asset;

/**
 封面图
 */
@property (nonatomic, strong) UIImage	*thumbImage;

/**
 原图
 */
@property (nonatomic, strong) UIImage	*sourceImage;

/**
 原始数据
 */
@property (nonatomic, strong) NSData	*sourceData;

@end
