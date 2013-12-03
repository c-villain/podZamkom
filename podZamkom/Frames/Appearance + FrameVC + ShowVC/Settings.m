//
//  Settings.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Settings.h"

@implementation Settings

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

+(void)increaseAppLaunchConting
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    NSInteger launchCount = [userDefaults integerForKey:@"launchCount"];
    launchCount ++;
    [userDefaults setInteger:launchCount forKey:@"launchCount"];
    [userDefaults synchronize];
}

+(NSInteger)getLaunchCount
{
    NSUserDefaults * userDefaults= [[NSUserDefaults alloc] init];
    return [userDefaults integerForKey:@"launchCount"];
}
@end
