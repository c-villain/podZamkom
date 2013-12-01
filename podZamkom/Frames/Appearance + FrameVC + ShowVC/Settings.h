//
//  Settings.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+(void)saveSelectedLanguage:(NSString*)language;
+(void)setDefaultLanguage;
+(void)setNotFirstAppRun;

@end
