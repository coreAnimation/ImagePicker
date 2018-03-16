//
//  JRImageListCell.m
//  JRImagePicker
//
//  Created by wxiao on 2018/3/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRImageListCell.h"
#import "JRAlbum.h"
#import "Header.h"

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
		UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 49, 49)];
		[self.contentView addSubview:imgView];
		imgView;
	});
	
	self.titleLabel = ({
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(74, 0, 200, 44)];
		[self.contentView addSubview:label];
		label;
	});
	
	self.selectedBtn = ({
		CGRect frame = CGRectMake(Screen_w - 80, 0, 49, 49);
		UIButton *sel = [[UIButton alloc] initWithFrame:frame];
//		[sel setImage:[UIImage imageNamed:@"original"] forState:UIControlStateNormal];
		[sel setImage:[UIImage imageNamed:@"originaled"] forState:UIControlStateSelected];
		[self.contentView addSubview:sel];
		sel;
	});
}

- (void)setAlbum:(JRAlbum *)album {
	_album = album;
	
	self.imgView.image = album.image;
	self.titleLabel.text = album.name;
	
	if (album.indexPathList.count > 0) {
		self.selectedBtn.selected = YES;
	} else {
		self.selectedBtn.selected = NO;
	}
}

@end
