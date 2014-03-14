//
//  Settings.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+(NSString*)getCurrentDate
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, YYYY hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}

+(NSDate *)getDateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"MMM dd, YYYY hh:mm:ss"];
    return [dateFormatter dateFromString:dateString];
}

+(NSString *)getStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, YYYY hh:mm:ss"];
    
    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    return [formatter stringFromDate:date];
}


+(void)saveSelectedLanguage:(NSString*)language
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:language forKey:@"Language"];
    [userDefaults synchronize];
}

+(void)setDefaultLanguage
{
    
    NSString *language = @"en";
    if ([[[NSLocale preferredLanguages] objectAtIndex:0]  isEqual: @"ru"])
        language = @"ru";
    if ([[[NSLocale preferredLanguages] objectAtIndex:0]  isEqual: @"fr"])
        language = @"fr";
    if ([[[NSLocale preferredLanguages] objectAtIndex:0]  isEqual: @"de"])
        language = @"de";
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:language forKey:@"Language"];
    [userDefaults synchronize];
}

+(void)setNotFirstAppRun
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNotFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}

+(BOOL)isNotFirstAppRun
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isNotFirstRun"];
}

+(BOOL)isTipWasShown
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isTipWasShown"];
}

+(void)setTipWasShown
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTipWasShown"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}

+(void)increaseAppLaunchConting
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    NSInteger launchCount = [userDefaults integerForKey:@"launchCount"];
    launchCount ++;
    [userDefaults setInteger:launchCount forKey:@"launchCount"];
    [userDefaults synchronize];
}

+(NSString *)getCurrentVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+(void)setVersionWhenRateUsed
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:[self getCurrentVersion] forKey:@"rateLastVersionUsed"];
    [userDefaults synchronize];
}

+(NSString *)getVersionWhenRateUsed
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"rateLastVersionUsed"];

}

+(void)setDateWhenRateUsed
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:[self getCurrentDate] forKey:@"rateDateUsed"];
    [userDefaults synchronize];
}

+(void)setRate
{
    [self setDateWhenRateUsed];
    [self setVersionWhenRateUsed];
}

+(NSDate *)getDateWhenRateUsed
{
    return [self getDateFromString:[[NSUserDefaults standardUserDefaults] stringForKey:@"rateDateUsed"]];
}


+(void)setDateSync
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:[self getCurrentDate] forKey:@"lastSyncDate"];
    [userDefaults synchronize];
}

+(NSString *)getLastDateSync
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastSyncDate"])
        return [[NSUserDefaults standardUserDefaults] stringForKey:@"lastSyncDate"];
    return @"";
}

+(void)deleteLastDateSync
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setObject:@"" forKey:@"lastSyncDate"];
    [userDefaults synchronize];
}
    
+(NSInteger)getLaunchCount
{
    NSUserDefaults * userDefaults= [[NSUserDefaults alloc] init];
    return [userDefaults integerForKey:@"launchCount"];
}

+(BOOL)isLinkWithDropBox
{
    NSInteger sync = [[NSUserDefaults standardUserDefaults] integerForKey:@"dropbox.sync.linked"];
    if (sync > 0)
        return YES;
    return NO;
}

@end
