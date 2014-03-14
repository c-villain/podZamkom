//
//  Sync.h
//  podZamkom
//
//  Created by Alexander Kraev on 31.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Security.h"
#import "NSString+Hash.h"
#import "DBlib.h"

@class Sync;
@protocol SyncDelegate<NSObject>
@optional
- (void)RestoreProcessed:(CGFloat)progress;
@end

@interface Sync : NSObject <RecryptDelegate>
{
    NSString *BUname;
    NSString *BUpath;
}
@property (nonatomic, weak) id<SyncDelegate> restoreDelegate;

+(int32_t)CreateBackup;
-(int)RestoreBackup:(NSString *) backupPassword;
+(BOOL)DeleteBackupFolder;
@end
