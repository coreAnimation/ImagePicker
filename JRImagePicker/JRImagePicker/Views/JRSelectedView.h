//
//  JRSelectedView.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/23.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JRSelectedViewDelegate <NSObject>

/**
 点击底部操作按钮
 @param sender 按钮
 */
- (void)selectedViewDidClicked:(UIButton *)sender;

@end


@interface JRSelectedView : UIView

/// 代理对象
@property (nonatomic, weak) id<JRSelectedViewDelegate> delegate;

/// 创建底部选择控件
+ (instancetype)selectedView;

/// 设置选择数量
- (void)setSelectedNumber;

@end
