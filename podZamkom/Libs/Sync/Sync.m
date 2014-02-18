//
//  Sync.m
//  podZamkom
//
//  Created by Alexander Kraev on 31.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "Sync.h"

@implementation Sync

-(id)init
{/*
    //Database name
    BUname = @"underlock";
    
    //Getting DB Path
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSError *error;
    NSString *dbDir = [dbPath objectAtIndex:0];
    BUpath = [dbDir stringByAppendingPathComponent:BUname];
    return self;
    */
    //Database name
    BUname = @"cash.underlock";
    
    //Getting DB Path
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSError *error;
    NSString *dbDir = [dbPath objectAtIndex:0];
    BUpath = [dbDir stringByAppendingPathComponent:@"Backup"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:BUpath])
        
        [[NSFileManager defaultManager] createDirectoryAtPath:BUpath withIntermediateDirectories:NO attributes:nil error:&error];
    
    BUpath = [dbDir stringByAppendingPathComponent:@"Backup/cash.underlock"];
    return self;
}

-(void)checkAndCreateBuFile
{
    BOOL Success;
    
    //NSFileManager maintains file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Checks Database Path
    Success = [fileManager fileExistsAtPath:BUpath];
    if (Success)
        return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:BUname];
    [fileManager copyItemAtPath:databasePathFromApp toPath:BUpath error:nil];
}

- (void)writeStringToFile:(NSString*)aString
{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:BUpath]) {
        [[NSFileManager defaultManager] createFileAtPath:BUpath contents:nil attributes:nil];
    }
    
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:BUpath atomically:NO];
}

- (NSString*)readValueFromFileWithKey: (NSString *)key
{
    NSString *data = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:BUpath] encoding:NSUTF8StringEncoding];
    NSRange range = [data rangeOfString:key];
    NSString *substring = [[data substringFromIndex:NSMaxRange(range) + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    range = [substring rangeOfString:@"}"];
    substring = [[substring substringToIndex:NSMaxRange(range) - 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return substring;
}

+ (NSString *)PasswordHashKey
{
    NSString *passwordHash = @"{password hash:";
    passwordHash = [passwordHash stringByAppendingString: [[Security getPassword] sha256String]];
    passwordHash = [passwordHash stringByAppendingString:@"}"];
    return passwordHash;
}

+(int32_t)CreateBackup
{
    Sync *sync = [[Sync alloc] init];
    [sync checkAndCreateBuFile];
    [sync writeStringToFile:[self PasswordHashKey]];
    
    NSString *data = [sync readValueFromFileWithKey:@"password hash"];
    NSLog(@"password hash is %@", data);
    
    return [DBadapter BackupDb];
}

+(int)RestoreBackup:(NSString *) backupPassword
{
    Sync *sync = [[Sync alloc] init];
    NSString *passwdEtalon = [sync readValueFromFileWithKey:@"password hash"];
    if (![passwdEtalon isEqualToString:[backupPassword sha256String]])
        return 1;
    if ([DBadapter RestoreDb])
        return 2;
    NSString *currentPasswd = [Security getPassword];
    [Security savePassword:backupPassword];
    if (![DBadapter DBRecryptWithPassword:currentPasswd])
        return 3;
    [Security savePassword:currentPasswd];
    return 0;
}

+(BOOL)DeleteBackupFolder
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    
    //Checks Database Path
    //создаем пути, куда сохранять:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    NSString *dirPath = [documentsDirectory stringByAppendingPathComponent:@"/Backup"];
    
    BOOL isDirectory;
    
    //проверяем существует ли директория Backup:
    if (![manager fileExistsAtPath:dirPath isDirectory:&isDirectory] || !isDirectory)
    {
        [manager removeItemAtPath:dirPath error:&error];
        if (error != nil)
            return NO;
    }
    return YES;
}
@end
