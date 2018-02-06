//
//  JRCollectionView.m
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/7.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRCollectionView.h"

@interface JRCollectionView () 

@end

@implementation JRCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
	self = [super initWithFrame:frame collectionViewLayout:layout];

	NSLog(@"asdasdasdsad");
	self.panGestureRecognizer.delegate = self;
	
	return self;
}
//
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//
//	NSLog(@"====== %@", gestureRecognizer.view);
//	return YES;
//}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//	return YES;
//}

@end
