//
//  JRBrowerController.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAsset;

@protocol JRBrowerControllerDelegate <NSObject>

/// 
- (void)selectAsset:(JRAsset *)asset isSelected:(BOOL)selected;

@end


@interface JRBrowerController : UIViewController

/**
 代理对象
 */
@property (nonatomic, weak) id<JRBrowerControllerDelegate>	delegate;

+ (instancetype)browerController:(NSArray<JRAsset *>*)assetList currentIndex:(NSInteger)index;

@end
