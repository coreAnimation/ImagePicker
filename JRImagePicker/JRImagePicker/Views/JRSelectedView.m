//
//  JRSelectedView.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/23.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRSelectedView.h"
#import "Header.h"
#import "JRAlbumManager.h"

@interface JRSelectedView ()

/// 预览
@property (nonatomic, strong) UIButton	*throughBtn;
/// 编辑
@property (nonatomic, strong) UIButton	*editBtn;
/// 完成
@property (nonatomic, strong) UIButton	*accomplishBtn;

@end

@implementation JRSelectedView

+ (instancetype)selectedView {
	
	JRSelectedView *selectedView = [[JRSelectedView alloc] initWithFrame:CGRectMake(0, Screen_h - Sele_Bar_h, Screen_w, Sele_Bar_h)];
	[selectedView setupView];
	return selectedView;
}

///
- (void)setupView {
	
	///
	self.backgroundColor = [UIColor grayColor];
	
	/// 浏览
	self.throughBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, Sele_Bar_h)];
	self.throughBtn.tag = 1;
	[self.throughBtn setTitle:@"预览" forState:UIControlStateNormal];
	self.throughBtn.titleLabel.font = [UIFont systemFontOfSize:16];
	self.throughBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[self addSubview:self.throughBtn];
	[self.throughBtn addTarget:self action:@selector(throughAction:) forControlEvents:UIControlEventTouchUpInside];

	/// 编辑
	self.editBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 50, Sele_Bar_h)];
	[self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
	self.editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
	[self addSubview:self.editBtn];
	self.editBtn.tag = 2;
	[self.editBtn addTarget:self action:@selector(throughAction:) forControlEvents:UIControlEventTouchUpInside];
	self.editBtn.hidden = YES;
	
	/// 原图
	self.originalBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_w - 50) * 0.5, 0, 120, Sele_Bar_h)];
	[self.originalBtn setTitle:@"原图" forState:UIControlStateNormal];
	[self.originalBtn setImage:[UIImage imageNamed:@"originaled"] forState:UIControlStateSelected];
	[self.originalBtn setImage:[UIImage imageNamed:@"original"] forState:UIControlStateNormal];
	self.originalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
	self.originalBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[self addSubview:self.originalBtn];
	self.originalBtn.tag = 3;
	[self.originalBtn addTarget:self action:@selector(throughAction:) forControlEvents:UIControlEventTouchUpInside];
	
	/// 完成
	self.accomplishBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_w - 70, 7, 60, Sele_Bar_h - 14)];
	[self.accomplishBtn setTitle:@"完成" forState:UIControlStateNormal];
	self.accomplishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
	[self addSubview:self.accomplishBtn];
	self.accomplishBtn.backgroundColor = [UIColor greenColor];
	self.accomplishBtn.layer.cornerRadius = 2;
	self.accomplishBtn.tag = 4;
	[self.accomplishBtn addTarget:self action:@selector(throughAction:) forControlEvents:UIControlEventTouchUpInside];
	
}

/// 设置选择图片数量
- (void)setSelectedNumber {
	
	NSInteger count = [JRAlbumManager sharedAlbumManager].selectedItem.count;
	
	if (count == 0) {
		[self.accomplishBtn setTitle:@"完成" forState:UIControlStateNormal];
	} else {
		NSString *title = [NSString stringWithFormat:@"(%zd)完成", count];
		[self.accomplishBtn setTitle:title forState:UIControlStateNormal];
	}
}

/// 操作
- (void)throughAction:(UIButton *)sender {
	
	/// 1:预览, 2:编辑, 3:原图, 4:完成
	if ([self.delegate respondsToSelector:@selector(selectedViewDidClicked:)]) {
		[self.delegate selectedViewDidClicked:sender];
	}
}

@end
