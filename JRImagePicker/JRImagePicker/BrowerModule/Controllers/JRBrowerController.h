//
//  JRBrowerController.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAsset;
@interface JRBrowerController : UIViewController

+ (instancetype)browerController:(NSArray<JRAsset *>*)assetList currentIndex:(NSInteger)index;

@end
