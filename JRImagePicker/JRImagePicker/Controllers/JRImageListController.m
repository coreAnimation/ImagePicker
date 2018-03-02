//
//  JRImageListController.m
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/21.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRImageListController.h"
#import "JRImagePickerController.h"
#import <Photos/Photos.h>
#import "JRAlbumManager.h"
#import "JRAlbum.h"

@interface JRImageListController () <UITableViewDelegate, UITableViewDataSource>

///
@property (nonatomic, strong) UITableView	*tableView;
///
@property (nonatomic, strong) NSArray<JRAlbum *>	*dataList;

@end

@implementation JRImageListController

+ (UINavigationController *)imageListController {
	
	JRImageListController *imgList = [JRImageListController new];
	UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:imgList];
	return navVC;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.delegate 	= self;
	self.tableView.dataSource 	= self;
	self.tableView.rowHeight  	= 50;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.view addSubview: self.tableView];
	
	
	UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"取消"
															   style:UIBarButtonItemStylePlain
															  target:self
															  action:@selector(finishAction)];
	
	self.navigationItem.rightBarButtonItem = finish;
	
	
	JRAlbumManager *manager = [JRAlbumManager sharedAlbumManager];
	[manager fetchAlbumResource];
	self.dataList = manager.albumList;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
//	JRAlbumManager *manager = [JRAlbumManager sharedAlbumManager];
//	[manager fetchAlbumResource];
//	self.dataList = manager.albumList;
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	
	JRAlbum *model = self.dataList[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", model.name, model.count];
	cell.imageView.image = model.image;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	JRImagePickerController *vc = [JRImagePickerController new];
	JRAlbum *model = self.dataList[indexPath.row];
	vc.album = model;
	[self.navigationController pushViewController:vc animated:YES];

}

/// 完成操作
- (void)finishAction {
	[self dismissViewControllerAnimated:YES completion:nil];
}


///
- (void)dealloc {
	///
	[[JRAlbumManager sharedAlbumManager].selectedItem removeAllObjects];
}

@end
