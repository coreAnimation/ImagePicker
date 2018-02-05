//
//  JRImageCell.h
//  JRImagePicker
//
//  Created by wxiao on 2018/2/5.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class JRAlbum;
@class PHAsset;
@interface JRImageCell : UICollectionViewCell

/**
 模型
 */
//@property (nonatomic, strong) JRAlbum	*model;

@property (nonatomic, strong) PHAsset	*asset;

@end
