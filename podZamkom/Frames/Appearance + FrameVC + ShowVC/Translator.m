//
//  Translator.m
//  podZamkom
//
//  Created by Alexander Kraev on 29.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Translator.h"

@implementation Translator

+(NSString *)languageSelectedStringForKey:(NSString *) key
{
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"Language"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    if ( !path )
        
        return NSLocalizedString(key, nil);
    
    return [[NSBundle bundleWithPath:path] localizedStringForKey:(key) value: @"" table:nil];
}

@end
