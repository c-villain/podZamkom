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
    [dateFormatter setDateFormat:@"MMM dd, YYYY hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}

+(NSDate *)getDateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"MMM dd, YYYY hh:mm"];
    return [dateFormatter dateFromString:dateString];
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

+(NSInteger)getLaunchCount
{
    NSUserDefaults * userDefaults= [[NSUserDefaults alloc] init];
    return [userDefaults integerForKey:@"launchCount"];
}
@end
