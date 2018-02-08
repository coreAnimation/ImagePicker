//
//  JRImageCell.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class JRAlbum;
@class JRAsset;

@protocol JRImageCellDelegate <NSObject>
@optional

/// 选中
- (void)selectAsset:(NSIndexPath *)indexPath asset:(JRAsset *)asset isSelected:(BOOL)selected;

@end


@interface JRImageCell : UICollectionViewCell

/**
 模型
 */
@property (nonatomic, strong) JRAsset	*asset;

/**
 是否被选中
 */
@property (nonatomic, assign) BOOL		isSelected;

/**
 临时选中
 */
@property (nonatomic, assign) BOOL		tmpSelected;

/**
 选中索引
 */
@property (nonatomic, strong) NSIndexPath	*indexPath;

/**
 代理对象
 */
@property (nonatomic, strong) id<JRImageCellDelegate>	delegate;

@end
