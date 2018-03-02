//
//  JRImageListCell.m
//  JRImagePicker
//
//  Created by wxiao on 2018/3/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRImageListCell.h"

@interface JRImageListCell ()

/// 封面
@property (nonatomic, strong) UIImageView	*imgView;
/// 标题
@property (nonatomic, strong) UILabel		*titleLabel;
/// 是否选择按钮
@property (nonatomic, strong) UIButton		*selectedBtn;
/// 更多标识
@property (nonatomic, strong) UIImageView	*moreImage;

@end


@implementation JRImageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	[self setupView];
	
	return self;
}

/// 初始化界面
- (void)setupView {
	
	///
	self.imgView =({
		UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		imgView.backgroundColor = [UIColor orangeColor];
		[self.contentView addSubview:imgView];
		imgView;
	});
	
	self.titleLabel = ({
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, 0, 200, 44)];
		label.backgroundColor = [UIColor orangeColor];
		[self.contentView addSubview:label];
		label;
	});
	
}

@end
