//
//  JRBrowerHeaderView.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/27.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRBrowerHeaderView.h"
#import "Header.h"
#import "JRSelectedButton.h"
#import "JRAsset.h"
#import "JRAlbumManager.h"

@interface JRBrowerHeaderView ()

@end


@implementation JRBrowerHeaderView

+ (instancetype)browerHeaderView {
	
	CGRect frame = CGRectMake(0, -Nav_h, Screen_w, Nav_h);
	
	JRBrowerHeaderView *header = [[JRBrowerHeaderView alloc] initWithFrame:frame];
	[header setupView];
	return header;
}

- (void)setupView {
	
	/// 背景色
	self.backgroundColor = [UIColor whiteColor];
	
	/// 返回按钮
	self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 66, 44)];
	[self.backBtn setTitle:@"back" forState:UIControlStateNormal];
	[self addSubview:self.backBtn];
	
	/// 选择状态
	self.selectedBtn = [[JRSelectedButton alloc] initWithFrame:CGRectMake(Screen_w - 44, 20, 44, 44)];
	[self.selectedBtn addTarget:self action:@selector(addAct:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:self.selectedBtn];
	
	
	self.selectedBtn.backgroundColor = [UIColor orangeColor];
	self.backBtn.backgroundColor = [UIColor orangeColor];
}

- (void)addAct:(UIButton *)sender {
	sender.selected = !sender.selected;

	//
	self.asset.isSelected = sender.selected;
	
//	if ([self.delegate respondsToSelector:@selector(selectedAsset:selected:)]) {
//		[self.delegate selectedAsset:self.asset selected:self.selectedBtn.selected];
//	}
}

- (void)setAppearance:(BOOL)appearance {
	
	if (_appearance != appearance) {

		CGRect frame = CGRectMake(0, 0, Screen_w, Nav_h);
		if (!appearance) {
			frame = CGRectMake(0, -Nav_h, Screen_w, Nav_h);
		}
		[UIView animateWithDuration:0.2 animations:^{
			self.frame = frame;
		}];

		_appearance = appearance;
	}
}

- (void)setAsset:(JRAsset *)asset {
	_asset = asset;
	
	self.selectedBtn.selected = asset.isSelected;

	NSInteger index = [[JRAlbumManager sharedAlbumManager].selectedItem indexOfObject:asset];
	if (index != NSNotFound) {
		self.selectedBtn.number = index + 1;
	}
}

@end
