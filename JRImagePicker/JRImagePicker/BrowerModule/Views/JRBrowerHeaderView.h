//
//  JRBrowerHeaderView.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRAsset;
@class JRSelectedButton;

@protocol JRBrowerHeaderViewDelegate <NSObject>

- (void)selectedAsset:(JRAsset *)asset selected:(BOOL)isSelected;

@end


@interface JRBrowerHeaderView : UIView

/// 是否隐藏
@property (nonatomic, assign) BOOL	appearance;

/// 返回按钮
@property (nonatomic, strong) UIButton	*backBtn;

@property (nonatomic, strong) JRAsset	*asset;

@property (nonatomic, assign) NSInteger	index;

@property (nonatomic, assign) BOOL		isSelected;

@property (nonatomic, strong) JRSelectedButton	*selectedBtn;

@property (nonatomic, weak) id<JRBrowerHeaderViewDelegate>	delegate;

+ (instancetype)browerHeaderView;

@end
