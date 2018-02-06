//
//  JRImagePickerController.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAlbum;

@interface JRImagePickerController : UIViewController

/**
 相册
 */
@property (nonatomic, strong) JRAlbum	*album;

@end
