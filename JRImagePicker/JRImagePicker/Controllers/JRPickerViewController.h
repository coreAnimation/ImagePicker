//
//  JRPickerViewController.h
//  JRImagePicker
//
//  Created by wxiao on 2018/3/6.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRImageListController.h"

@interface JRPickerViewController : UINavigationController

@property (nonatomic, weak) id<JRImageListControllerDelegate>	delegate;

/**
 获取单粒

 @return 单粒
 */
+ (instancetype)pickerViewController;

@end
