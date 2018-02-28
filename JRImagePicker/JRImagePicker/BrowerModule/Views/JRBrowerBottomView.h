//
//  JRBrowerBottomView.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRBrowerBottomView : UIView

/**
 是否隐藏
 */
@property (nonatomic, assign) BOOL	appearance;

/**
 获取底部选择条

 @return 底部选择条
 */
+ (instancetype)browerBottomView;

@end
