//
//  NSString+Hash.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.02.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)md5String;
- (NSString *)sha1String;
- (NSString *)sha256String;
- (NSString *)sha512String;

@end
