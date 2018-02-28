//
//  JRSelectedButton.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/8.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRSelectedButton.h"

@interface JRSelectedButton ()

/// 选中 layer
@property (nonatomic, strong) CATextLayer	*selectLayer;

@end


@implementation JRSelectedButton

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setupView];
	return self;
}

/// 初始化界面
- (void)setupView {
	
	/// 未选中 layer
	CGFloat w = 24;
	CALayer *noSelectLayer = [CALayer layer];
	noSelectLayer.bounds = CGRectMake(0, 0, w, w);
	noSelectLayer.position = CGPointMake(22, 18);
	noSelectLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
	noSelectLayer.cornerRadius	= w * 0.5; 
	noSelectLayer.borderWidth = 1;
	noSelectLayer.borderColor = [UIColor whiteColor].CGColor;
	[self.layer addSublayer:noSelectLayer];

	/// 未选中 layer
	self.selectLayer = [CATextLayer layer];
	self.selectLayer.backgroundColor = [UIColor blueColor].CGColor;
	self.selectLayer.position = noSelectLayer.position;//CGPointMake(23 * 0.5, 23 * 0.5);
	self.selectLayer.cornerRadius	= 11;
//	self.bounds = CGRectMake(0, 0, 0, 0);
	[self.layer addSublayer:self.selectLayer];
	
//	self.selectLayer.string = @"1";
	self.selectLayer.fontSize = 18;
	self.selectLayer.alignmentMode = kCAAlignmentCenter;
	self.selectLayer.contentsScale = [UIScreen mainScreen].scale;
}

/// 设置选择状态
- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];

	if (selected) {

		[CATransaction begin];
		[CATransaction setAnimationDuration:0.1];
		self.selectLayer.bounds = CGRectMake(0, 0, 22, 22);
		self.selectLayer.cornerRadius	= 11;
		[CATransaction commit];
	
	} else {
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
		self.selectLayer.bounds = CGRectZero;
		[CATransaction commit];
	}
	
}

- (void)setNumber:(NSInteger)number {
	_number = number;

	[CATransaction begin];
	[CATransaction setDisableActions:NO];
	self.selectLayer.string = [NSString stringWithFormat:@"%zd", number];
	[CATransaction commit];
	
}

@end
