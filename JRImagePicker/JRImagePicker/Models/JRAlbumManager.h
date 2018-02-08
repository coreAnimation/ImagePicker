//
//  JRAlbumManager.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JRAlbum;
@class JRAsset;
@interface JRAlbumManager : NSObject

/**
 获取图像管理单粒

 @return 相册内容管理单粒
 */
+ (instancetype)sharedAlbumManager;

/**
 相册列表
 */
@property (nonatomic, strong) NSArray<JRAlbum *>	*albumList;

/**
 选中的资源
 */
@property (nonatomic, strong) NSMutableArray<JRAsset *>	*selectedItem;

/**
 获取相册资源
 */
- (void)fetchAlbumResource;

@end
