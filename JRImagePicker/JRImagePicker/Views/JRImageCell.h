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
@interface JRImageCell : UICollectionViewCell

/**
 模型
 */
@property (nonatomic, strong) JRAsset	*asset;

/**
 是否被选中
 */
@property (nonatomic, assign) BOOL		isSelected;

@end
