//
//  Security.m
//  Под замком
//
//  Created by Alexander Kraev on 04.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Security.h"

@implementation Security


+(void)savePassword:(NSString*)password
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    [keyChainItem setObject:password forKey:(__bridge id)(kSecValueData)];
}

+(NSString*)getPassword
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    return [keyChainItem objectForKey:(__bridge id)(kSecValueData)];
}

+(void)saveXtraPassword:(NSString*)xtraPassword
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    [keyChainItem setObject:xtraPassword forKey:(__bridge id)(kSecAttrService)];
}

+(NSString*)getXtraPassword
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    return [keyChainItem objectForKey:(__bridge id)(kSecAttrService)];
}

+(void)saveUseOrNotPassword:(BOOL)use
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    NSString * strUse = (use) ? @"True" : @"False";
    [keyChainItem setObject:strUse forKey:(__bridge id)(kSecAttrLabel)];
}

+(BOOL)getUseOrNotPassword
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    if (![[keyChainItem objectForKey:(__bridge id)(kSecAttrLabel)]  isEqual: @"True"])
        return NO;
    return YES;
}

+(void)saveDeleteorNotFilesAfterTenErrors:(BOOL)delete
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    NSString * strDelete= (delete) ? @"True" : @"False";
    [keyChainItem setObject:strDelete forKey:(__bridge id)(kSecAttrGeneric)];
}

+(BOOL)getDeleteorNotFilesAfterTenErrors
{
    KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.c-villain.podZamkom" accessGroup:nil];
    if (![[keyChainItem objectForKey:(__bridge id)(kSecAttrGeneric)]  isEqual: @"True"])
        return NO;
    return YES;
}
@end
