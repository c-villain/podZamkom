//
//  DBadapter.m
//  Под замком
//
//  Created by Alexander Kraev on 13.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBadapter.h"

#define DB "\
CREATE TABLE IF NOT EXISTS DocList (pk_doc_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , doc_type INTEGER NOT NULL, date_of_creation DATETIME NOT NULL); \
\
CREATE  TABLE IF NOT EXISTS Note (pk_note_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, content BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id));\
\
CREATE  TABLE IF NOT EXISTS CreditCard (pk_card_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, bank BLOB, holder BLOB, card_type INTEGER, number BLOB, validThru BLOB, cvc BLOB, pin BLOB, card_color INTEGER, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id) ); \
\
CREATE  TABLE IF NOT EXISTS Login (pk_login_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, url BLOB, user_name BLOB, password BLOB, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id)); \
\
CREATE  TABLE IF NOT EXISTS BankAccount (pk_account_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, bank BLOB, account_number BLOB, currency_type INTEGER, bik BLOB, correspond_number BLOB, inn BLOB, kpp BLOB, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id) );\
\
CREATE  TABLE IF NOT EXISTS Passport (pk_passport_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, name BLOB, country INTEGER, number BLOB, department BLOB, date_of_issue BLOB, department_code BLOB, holder BLOB, birth_date BLOB, birth_place BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id) ); \
\
CREATE TABLE IF NOT EXISTS PhotoDoc (pk_photo_doc_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, fk_doc_id INTEGER, groupName BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id)); \
\
CREATE TABLE IF NOT EXISTS Photos (pk_photo_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, fk_doc_id INTEGER, photo BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id));"

@implementation DBadapter

-(id)init
{
    //Database name
    DBname = @"podzamkom.sqlite";

    //Getting DB Path
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    NSString *dbDir = [dbPath objectAtIndex:0];
    DBpath = [dbDir stringByAppendingPathComponent:DBname];
    return self;
}

-(void)checkAndCreateDBFile
{
    BOOL Success;

    //NSFileManager maintains file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Checks Database Path
    Success = [fileManager fileExistsAtPath:DBpath];
    if (Success)
        return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:DBname];
    [fileManager copyItemAtPath:databasePathFromApp toPath:DBpath error:nil];
   
}

-(void)CreateDBTablesIfNotExists
{
    //create DB tables if its not exist
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        char* sErrMsg = nil;
        if (sqlite3_exec(db, DB, NULL, NULL, &sErrMsg) == SQLITE_OK)
            return;
        NSLog(@"%s",sErrMsg);
        return;
    }
}

//insert docType and Date of creation
//return id of inserting row
-(int)insertIntoDocList:(int)docType
{
    sqlite3_stmt *statement;
    const char *insert_stmt = "INSERT INTO DocList(doc_type, date_of_creation) VALUES(?,?)";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docType);
            sqlite3_bind_text(statement, 2, [[Settings getCurrentDate] UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                int DocListRowId = (int)sqlite3_last_insert_rowid(db);
                sqlite3_close(db);
                return DocListRowId;
            }
        }
    }
    return 0;
}


//0 - fail
//1 - ok, but no photos for doc
//2 - ok, all photos save in db
-(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray withKey:(NSString *) key
{
    int64_t k = [photoArray count];
    if (k == 0)
        return 1;

    for (int photoIndex = 0 ; photoIndex < k; photoIndex++)
    {
        sqlite3_stmt *statement;
        const char *insert_stmt = "INSERT INTO Photos(fk_doc_id, photo) VALUES(?,?)";
        sqlite3 *db;
        if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
        {
            sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
            {
                //get nsdata from uiimage and save it as blob in db:
                UIImage *img = [photoArray objectAtIndex:photoIndex];
                
                NSData *imgData = UIImagePNGRepresentation(img);
                
                NSData *encryptedData = [FBEncryptorAES encryptImage:imgData withKey:key];
                
                sqlite3_bind_int(statement, 1, docId);
                sqlite3_bind_blob(statement, 2, [encryptedData bytes], (int)[encryptedData length], SQLITE_TRANSIENT);
                
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    sqlite3_finalize(statement);
                    sqlite3_close(db);
                }
            }
        }
        else
            return 0;
    }
    return 2;
}

-(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray
{
    return [self insertPhotosWithDocId:docId photoList:photoArray withKey:[Security getPassword]];
}

+(int)insertPhotosWithDocId:(int)docId photoList:(NSMutableArray *)photoArray withKey:(NSString *) key
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    return [dbAdapter insertPhotosWithDocId:docId photoList:photoArray withKey:key];
}
@end
