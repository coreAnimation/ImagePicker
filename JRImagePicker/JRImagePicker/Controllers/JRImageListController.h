//
//  JRImageListController.h
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/21.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAsset;
@class JRImageListController;

@protocol JRImageListControllerDelegate <NSObject>

- (void)imageListController:(JRImageListController *)imageListControler
		finishPickingPhotos:(NSArray<JRAsset *> *)assets
	ifSelectedOriginalPhoto:(BOOL)isSelectOriginalPhoto;

@end


/// 图片列表
@interface JRImageListController : UIViewController

+ (UINavigationController *)imageListController;

/**
 代理对象
 */
@property (nonatomic, weak) id<JRImageListControllerDelegate>	delegate;

@end
