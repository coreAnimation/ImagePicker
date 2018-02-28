//
//  JRBrowerBottomView.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRBrowerBottomView.h"
#import "Header.h"

@implementation JRBrowerBottomView

+ (instancetype)browerBottomView {
	
	CGRect frame = CGRectMake(0, Screen_h, Screen_w, TabBar_h);
	JRBrowerBottomView *bottomView = [[JRBrowerBottomView alloc] initWithFrame:frame];
	
	[bottomView setupView];
	
	return bottomView;
}

- (void)setupView {
	self.backgroundColor = [UIColor whiteColor];
}

- (void)setAppearance:(BOOL)appearance {
	_appearance = appearance;
	
	CGRect frame = CGRectMake(0, Screen_h, Screen_w, TabBar_h);
	if (!_appearance) {
		frame = CGRectMake(0, Screen_h - TabBar_h, Screen_w, TabBar_h);
	}
	[UIView animateWithDuration:0.2 animations:^{
		self.frame = frame;
	}];
}

@end
