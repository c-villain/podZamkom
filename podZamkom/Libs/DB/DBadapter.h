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

@interface DBadapter : NSObject
{
    NSString *DBname;
    NSString *DBpath;
}

-(id)init;
-(void)checkAndCreateDBFile;
-(void)CreateDBTablesIfNotExists;

-(int)insertIntoDocList:(int)docType;

@end
