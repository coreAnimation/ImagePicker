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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	JRAlbumManager *manager = [JRAlbumManager sharedAlbumManager];
	[manager fetchAlbumResource];
	NSLog(@"== %@", manager.albumList);
	
	
	
	
//	JRImagePickerController *vc = [JRImagePickerController new];
//
////	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
////	[self presentViewController:nav animated:YES completion:nil];
//
//	[self.navigationController pushViewController:vc animated:YES];
	
}


@end
