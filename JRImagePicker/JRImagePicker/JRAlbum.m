//
//  JRAlbum.m
//  JRImagePicker
//
//  Created by wxiao on 2018/2/2.
//  Copyright © 2018年 王潇. All rights reserved.
//

#import "JRAlbum.h"

@implementation JRAlbum

///
- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - %zd", self.name, self.count];
}

@end
