//
//  JRPickerViewController.m
//  JRImagePicker
//
//  Created by wxiao on 2018/3/6.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRPickerViewController.h"

@interface JRPickerViewController ()

@property (nonatomic, strong) JRImageListController *listVC;

@end

@implementation JRPickerViewController

+ (instancetype)pickerViewController {

	JRImageListController *listVC = [JRImageListController new];
	JRPickerViewController *pickerVC = [[JRPickerViewController alloc] initWithRootViewController:listVC];
	pickerVC.listVC = listVC;
	
	return pickerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setDelegate:(id<JRImageListControllerDelegate>)delegate {
	
	self.listVC.delegate = delegate;
}


@end
