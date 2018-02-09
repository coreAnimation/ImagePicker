//
//  ViewController.m
//  JRImagePicker
//
//  Created by 王潇 on 2017/12/9.
//  Copyright © 2017年 王潇. All rights reserved.
//

#import "ViewController.h"
#import "JRImagePickerController.h"
#import <Photos/Photos.h>
#import "JRAlbumManager.h"
#import "JRAlbum.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

///
@property (nonatomic, strong) UITableView	*tableView;
///
@property (nonatomic, strong) NSArray<JRAlbum *>	*dataList;

//@property (nonatomic, strong) NSString		*testString;

@end

@implementation ViewController

//@synthesize testString = _myTestString;
//@dynamic testString;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	self.tableView.delegate 	= self;
	self.tableView.dataSource 	= self;
	self.tableView.rowHeight  	= 50;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.view addSubview: self.tableView];
	
	
}

//- (void)setTestString:(NSString *)testString {
//	_testString = testString;
//}

//- (NSString *)testString {
//	return _testString;
//}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	JRAlbumManager *manager = [JRAlbumManager sharedAlbumManager];
	[manager fetchAlbumResource];
	self.dataList = manager.albumList;
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
	
	//	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
	//	[self presentViewController:nav animated:YES completion:nil];
}




@end
