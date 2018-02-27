//
//  JRSelectedView.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/23.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRSelectedView : UIView

/// 创建底部选择控件
+ (instancetype)selectedView;

/// 设置选择数量
- (void)setSelectedNumber;

@end
