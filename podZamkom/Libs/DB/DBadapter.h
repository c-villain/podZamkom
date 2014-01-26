//
//  DBadapter.h
//  Под замком
//
//  Created by Alexander Kraev on 13.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FBEncryptorAES.h"
#import "DocumentLib.h"
#import "Settings.h"


@class DBadapter;
@protocol RecryptDelegate<NSObject>
@optional
- (void)RowWasProcessed:(CGFloat)progress;
@end


@interface DBadapter : NSObject
{
    NSString *DBname;
    NSString *DBpath;
}

@property (nonatomic, weak) id<RecryptDelegate> recryptDelegate;

-(id)init;
-(void)checkAndCreateDBFile;
-(void)CreateDBTablesIfNotExists;

-(int)insertIntoDocList:(int)docType;
+(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray withKey:(NSString *) key;
-(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray withKey:(NSString *) key;

-(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray;

@end
