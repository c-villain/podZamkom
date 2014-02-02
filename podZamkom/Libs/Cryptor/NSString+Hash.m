//
//  NSString+Hash.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.02.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "NSString+Hash.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Hash)

- (NSString *)md5String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_MD5_DIGEST_LENGTH];
	CC_MD5(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
	CC_SHA512(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - Helpers

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
	NSMutableString *mutableString = @"".mutableCopy;
	for (int i = 0; i < length; i++)
		[mutableString appendFormat:@"%02x", bytes[i]];
	return [NSString stringWithString:mutableString];
}


@end
