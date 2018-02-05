//
//  JRAlbum.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 <#Description#>
 */
@property (nonatomic, strong) PHFetchResult *fetchResult;


/**
 相册索引
 */
@property (nonatomic, strong) PHAssetCollection *collection;


@end
