//
//  DBBackup.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 02.02.14.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBBackup.h"

@implementation DBadapter (DBBackup)

/*
 ** This function is used to load the contents of a database file on disk
 ** into the "main" database of open database connection pInMemory, or
 ** to save the current contents of the database opened by pInMemory into
 ** a database file on disk. pInMemory is probably an in-memory database,
 ** but this function will also work fine if it is not.
 **
 ** If parameter isSave is non-zero, then the contents of the file db are
 ** overwritten with the contents of the database opened by pInMemory. If
 ** parameter isSave is zero, then the contents of the database opened by
 ** pInMemory are replaced by data loaded from the file db.
 **
 ** If the operation is successful, SQLITE_OK is returned. Otherwise, if
 ** an error occurs, an SQLite error code is returned.
 */
-(int)loadOrSaveDb:(int) isSave
{
    int rc;                   /* Function return code */
    sqlite3 *db;              /* Database connection opened on zFilename */
    sqlite3 *budb = NULL;
    sqlite3_backup *pBackup;  /* Backup object used to copy data */
    sqlite3 *pTo;             /* Database to copy to (pFile or pInMemory) */
    sqlite3 *pFrom;           /* Database to copy from (pFile or pInMemory) */
    

    [self checkAndCreateBuFile];
    rc = sqlite3_open([BUpath UTF8String], &budb);
    if( rc != SQLITE_OK )
        return rc;

    /* Open the database file identified by zFilename. Exit early if this fails
     ** for any reason. */
    rc = sqlite3_open([DBpath UTF8String], &db);
    if( rc==SQLITE_OK ){
        
        
        /* If this is a 'load' operation (isSave==0), then data is copied
         ** from the database file just opened to database pInMemory.
         ** Otherwise, if this is a 'save' operation (isSave==1), then data
         ** is copied from pInMemory to pFile.  Set the variables pFrom and
         ** pTo accordingly. */
        pFrom = (isSave ? budb : db);
        pTo   = (isSave ? db : budb);
        
        /* Set up the backup procedure to copy from the "main" database of
         ** connection pFile to the main database of connection pInMemory.
         ** If something goes wrong, pBackup will be set to NULL and an error
         ** code and  message left in connection pTo.
         **
         ** If the backup object is successfully created, call backup_step()
         ** to copy data from pFile to pInMemory. Then call backup_finish()
         ** to release resources associated with the pBackup object.  If an
         ** error occurred, then  an error code and message will be left in
         ** connection pTo. If no error occurred, then the error code belonging
         ** to pTo is set to SQLITE_OK.
         */
        pBackup = sqlite3_backup_init(pTo, "main", pFrom, "main");
        if( pBackup ){
            (void)sqlite3_backup_step(pBackup, -1);
            (void)sqlite3_backup_finish(pBackup);
        }
        rc = sqlite3_errcode(budb);
    }
    
    /* Close the database connection opened on database file zFilename
     ** and return the result of this function. */
    (void)sqlite3_close(db);
    (void)sqlite3_close(budb);
    return rc;
}

-(void)checkAndCreateBuFile
{/*
    //Database name
    BUname = @"backup.sqlite";
    
    //Getting DB Path
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    NSString *dbDir = [dbPath objectAtIndex:0];
    BUpath = [dbDir stringByAppendingPathComponent:BUname];
    */
    
    //Database name
    BUname = @"backup.sqlite";
    
    //Getting DB Path
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    
    NSError *error;
    NSString *dbDir = [dbPath objectAtIndex:0];
    BUpath = [dbDir stringByAppendingPathComponent:@"Backup"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:BUpath])
        
        [[NSFileManager defaultManager] createDirectoryAtPath:BUpath withIntermediateDirectories:NO attributes:nil error:&error];

    BUpath = [dbDir stringByAppendingPathComponent:@"Backup/backup.sqlite"];

    
    BOOL Success;
    
    //NSFileManager maintains file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Checks Database Path
    Success = [fileManager fileExistsAtPath:DBpath];
    if (Success)
        return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:BUname];
    [fileManager copyItemAtPath:databasePathFromApp toPath:BUpath error:nil];
}


+(int)BackupDb
{
    DBadapter *db = [[DBadapter alloc] init];
    return [db loadOrSaveDb: 0];
}

+(int)RestoreDb
{
    DBadapter *db = [[DBadapter alloc] init];
    return [db loadOrSaveDb: 1];
}

@end