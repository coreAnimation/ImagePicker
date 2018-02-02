//
//  JRAlbumManager.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRAlbumManager.h"
#import <Photos/Photos.h>
#import "JRAlbum.h"


@implementation JRAlbumManager

+ (instancetype)sharedAlbumManager {
	
	static JRAlbumManager *instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [JRAlbumManager new];
	});
	return instance;
}

/**
 获取资源
 */
- (void)fetchAlbumResource {
	
	/// 获取相册
	PHFetchOptions *option = [[PHFetchOptions alloc] init];
	option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
	//	option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",
	//											PHAssetMediaTypeVideo];
	
	PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
																		  subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
	
	/// 临时相册
	NSMutableArray *tmpAlbum = [NSMutableArray new];
	
	/// 遍历相册
	for (PHAssetCollection *collection in smartAlbums) {
		
		PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
		// 相册名字
		NSString *albumName = collection.localizedTitle;
		// 相册图片数量
		NSInteger albumNumb = fetchResult.count;
		JRAlbum *album = [JRAlbum new];
		album.name = albumName;
		album.count = albumNumb;
		[tmpAlbum addObject:album];
	}
	
	/// 保存相册列表
	self.albumList = tmpAlbum.copy;
}






@end
