//
//  JRBrowerCell.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRBrowerCell.h"
#import "Header.h"
#import "JRAsset.h"

@interface JRBrowerCell ()

@property (nonatomic, strong) UIScrollView	*scrollView;

@property (nonatomic, strong) UIImageView	*imgView;

@end

@implementation JRBrowerCell

- (instancetype)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	[self setupView];
	return self;
}

- (void)setupView {

	self.imgView = [[UIImageView alloc] init];
	CGFloat h = Screen_w * 0.5;
	CGFloat y = (Screen_h - h) * 0.5;
	self.imgView.frame = CGRectMake(0, y, Screen_w, h);
	self.imgView.backgroundColor = [UIColor yellowColor];
	[self.contentView addSubview:self.imgView];
}

///
- (void)setAsset:(JRAsset *)asset {
	_asset = asset;
	
	[asset getSoucreImage:^(UIImage *result, NSDictionary *info) {
		if (result) {
			CGSize size = result.size;
			
			CGFloat width = Screen_w;
			CGFloat height = width * (size.height / size.width);
			
			CGFloat y = (Screen_h - height) * 0.5;
			
			self.imgView.frame = CGRectMake(15, y, width, height);
			
			self.imgView.image = result;
		}
	}];
}

@end
