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

@end
