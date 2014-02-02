//
//  Settings.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+(NSString*)getCurrentDate;
+(NSDate *)getDateFromString:(NSString *)dateString;
+(void)saveSelectedLanguage:(NSString*)language;
+(void)setDefaultLanguage;
+(void)setNotFirstAppRun;
+(BOOL)isNotFirstAppRun;
+(void)increaseAppLaunchConting;
+(NSInteger)getLaunchCount;
+(NSString *)getCurrentVersion;
+(void)setVersionWhenRateUsed;
+(NSString *)getVersionWhenRateUsed;
+(void)setRate;
+(BOOL)isLinkWithDropBox;

@end
