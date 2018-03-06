//
//  JRImagePickerController.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRImageListController.h"

@class JRAlbum;

@interface JRImagePickerController : UIViewController

/**
 相册
 */
@property (nonatomic, strong) JRAlbum	*album;

/**
 代理对象
 */
@property (nonatomic, weak) id<JRImageListControllerDelegate>	delegate;

@end
