//
//  JRAlbum.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAsset;
@class PHFetchResult;
@class PHAssetCollection;
@interface JRAlbum : NSObject

/**
 相册名称
 */
@property (nonatomic, strong) NSString	*name;

/**
 相册资源数量
 */
@property (nonatomic, assign) NSInteger	count;

/**
 相册封面
 */
@property (nonatomic, strong) UIImage	*image;

/**
 获取资源
 */
@property (nonatomic, strong) PHFetchResult *fetchResult;

/**
 资源列表
 */
@property (nonatomic, strong) NSMutableArray<JRAsset *>		*assetList;

/**
 刷新列表
 */
@property (nonatomic, strong) NSMutableArray<NSIndexPath *>	*indexPathList;


/**
 相册索引
 */
@property (nonatomic, strong) PHAssetCollection *collection;


@end
