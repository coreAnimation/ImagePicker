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
#import "PHImageManager+JRExtension.h"

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
		
		/// 相册模型
		JRAlbum *album 		= [JRAlbum new];
		album.name 			= albumName;
		album.count 		= albumNumb;
		album.fetchResult 	= fetchResult;
		[tmpAlbum addObject:album];

		/// 获取相册封面
		PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
		option.resizeMode = PHImageRequestOptionsResizeModeFast;

		PHAsset *lastAsset = fetchResult.lastObject;

		if (lastAsset) {
			
			[PHImageManager jr_imageForAsset:lastAsset
								  targetSize:CGSizeMake(100, 100)
								  accomplish:^(UIImage *result, NSDictionary *info) {
									  if (result) { album.image = result; }
								  }];
		}
	}

	/// 保存相册列表
	self.albumList = tmpAlbum.copy;
}






@end
