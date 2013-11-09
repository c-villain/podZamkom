//
//  PhotoBox.h
//  podZamkom
//
//  Created by Alexander Kraev on 31.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "MGBox.h"

@interface PhotoBox : MGBox
{
    UIImagePickerController *picker;
}

+ (PhotoBox *)photoAddBoxWithSize:(CGSize)size;
+ (PhotoBox *)photoBoxFor:(int)i size:(CGSize)size;


- (void)loadPhoto;

@end
