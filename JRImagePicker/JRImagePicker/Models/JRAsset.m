//
//  JRAsset.m
//  JRImagePicker
//
//  Created by 王潇 on 2018/2/7.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRAsset.h"

@implementation JRAsset

- (BOOL)isEqual:(id)other
{
	if (other == self) {
		return YES;
	}
	if ([self class] != [other class]) {
		return NO;
	}
	
	if ([other isKindOfClass:[JRAsset class]]) {
		JRAsset *asset= (JRAsset *)other;
		return [self.asset isEqual:asset.asset];
	} else {
		return NO;
	}
}

- (NSUInteger)hash
{
	return [self.asset hash];
}

@end
