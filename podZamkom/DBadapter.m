//
//  DBadapter.m
//  Под замком
//
//  Created by Alexander Kraev on 13.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBadapter.h"

#define DB "CREATE TABLE IF NOT EXISTS DocType (pk_type_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , type TEXT NOT NULL  UNIQUE ); \
            CREATE TABLE IF NOT EXISTS DocList (pk_doc_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , fk_type_id INTEGER NOT NULL, \
                                                date_of_creation DATETIME NOT NULL, FOREIGN KEY(fk_type_id) REFERENCES DocumentType (pk_type_id) ); \
CREATE  TABLE IF NOT EXISTS Note (pk_note_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, content BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id));\
CREATE  TABLE IF NOT EXISTS CardType (pk_type_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, type TEXT NOT NULL  UNIQUE);\
INSERT OR IGNORE INTO CardType (type) VALUES ('VISA');\
INSERT OR IGNORE INTO CardType (type) VALUES ('VISA Electron');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Mastercard');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Maestro');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Cirrus');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Discover');\
INSERT OR IGNORE INTO CardType (type) VALUES ('JCB');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Carte Blanche');\
INSERT OR IGNORE INTO CardType (type) VALUES ('American Express');\
INSERT OR IGNORE INTO CardType (type) VALUES ('UnionPay');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Laser');\
INSERT OR IGNORE INTO CardType (type) VALUES ('Diners Club');\
CREATE  TABLE IF NOT EXISTS CreditCard (pk_card_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, name BLOB, surname BLOB, fk_type_id INTEGER, number BLOB, expDate BLOB, cvc BLOB, pin BLOB, bank BLOB, phone BLOB, word BLOB, url BLOB, login BLOB, password BLOB, creditLimit BLOB, note BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id), FOREIGN KEY(fk_type_id) REFERENCES CardType (pk_type_id)); \
            CREATE  TABLE IF NOT EXISTS Login (pk_login_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, \
                                                url BLOB, user_name BLOB, password BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id)); \
            INSERT OR IGNORE INTO DocType (type) VALUES ('Заметка'); \
            INSERT OR IGNORE INTO DocType (type) VALUES ('Логин');\
            INSERT OR IGNORE INTO DocType (type) VALUES ('Паспорт'); \
            INSERT OR IGNORE INTO DocType (type) VALUES ('Счет'); \
            INSERT OR IGNORE INTO DocType (type) VALUES ('Кредитка');"

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

-(NSString*)getCurrentDate
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm      dd-MM-yyyy"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}

//insert docType and Date of creation
//return id of inserting row
-(int)insertIntoDocList:(int)docType 
{
    sqlite3_stmt *statement;
    const char *insert_stmt = "INSERT INTO DocList(fk_type_id, date_of_creation) VALUES(?,?)";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docType);
            sqlite3_bind_text(statement, 2, [[self getCurrentDate] UTF8String], -1, SQLITE_TRANSIENT);
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

-(int)getIdOfDocType:(NSString*)docType
{
    sqlite3_stmt *statement;
    int typeId = 0;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_type_id FROM DocType WHERE type='%@'", docType];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK) 
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
                typeId = sqlite3_column_int(statement, 0);
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return typeId;
}

-(int)getCardTypeIdByCardType:(CardType *)cardType
{
    sqlite3_stmt *statement;
    int typeId = 0;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_type_id FROM CardType WHERE type='%@'", cardType.name];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
                typeId = sqlite3_column_int(statement, 0);
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return typeId;
}

-(NSString *)getDocTypeByTypeId:(int)idType
{
    sqlite3_stmt *statement;
    NSString *docType;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT type FROM DocType WHERE pk_type_id= %d", idType];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
                docType = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return docType;
}

-(NSString *)getDocTypeByDocId:(NSString *)idDoc
{
    sqlite3_stmt *statement;
    int idType = -1;
    NSString *docType;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT fk_type_id FROM DocList WHERE pk_doc_id= %d", [idDoc integerValue]];
    const char *query_stmt = [querySQL UTF8String];
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                idType = sqlite3_column_int(statement, 0);
                if (idType != -1)
                    docType = [self getDocTypeByTypeId:idType];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return docType;
}


-(NSString *)getDocumentName:(int)docId withDocType:(int)idDocType
{
    sqlite3_stmt *statement;
    NSString *querySQL;
    NSString *docType = [self getDocTypeByTypeId:idDocType];
    NSString *docName;
    if ([docType isEqual: @"Заметка"])
    {
        querySQL = [NSString stringWithFormat: @"SELECT title FROM Note WHERE fk_doc_id = %d", docId];
    }
    else if ([docType isEqual: @"Логин"])
    {
        querySQL = [NSString stringWithFormat: @"SELECT url FROM Login WHERE fk_doc_id = %d", docId];
        
    }
    else if ([docType isEqual: @"Счет"])
    {
        querySQL = [NSString stringWithFormat: @"SELECT url FROM Login WHERE fk_doc_id = %d", docId];
        
    }
    else if ([docType isEqual: @"Паспорт"])
    {
        querySQL = [NSString stringWithFormat: @"SELECT url FROM Login WHERE fk_doc_id = %d", docId];
        
    }
    else if ([docType isEqual: @"Кредитка"])
    {
        querySQL = [NSString stringWithFormat: @"SELECT title FROM CreditCard WHERE fk_doc_id = %d", docId];
        
    }
    //don't change this code!
    const char *query_stmt = [querySQL UTF8String];
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
                docName = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return docName;
}

//Ставит документу картинку в соответствии с его типом
//постоянно дополнять
-(void)setDocImage:(Document*)doc withDocType:(int)idDocType
{
     NSString *docType = [self getDocTypeByTypeId:idDocType];
    if ([docType isEqual: @"Заметка"])
    {
        doc.imageFile = @"addNotes.png";
    }
    else if ([docType isEqual: @"Логин"])
    {
        doc.imageFile = @"addLogin.png";
    }
    else if ([docType isEqual: @"Кредитка"])
    {
        doc.imageFile = @"addCredit.png";
    }
}

//читает все данные из таблицы DocList
-(NSArray *)ReadData
{
    [self checkAndCreateDBFile];
    [self CreateDBTablesIfNotExists];
    NSMutableArray *documents = [[NSMutableArray alloc] init]; //массив документов
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT *from DocList"];
    const char *query_stmt = [querySQL UTF8String];

    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Document *document = [Document new];
                document.idDoc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                int idDocType = sqlite3_column_int(statement, 1);
                document.docName = [self getDocumentName:[document.idDoc intValue] withDocType:idDocType];
                
                document.detail = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                [self setDocImage:document withDocType:idDocType];

                [documents addObject:document];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return documents;
}


-(BOOL)DeleteDocFromDB:(NSString *)idDoc
{
    sqlite3 *database;
    sqlite3_stmt *deleteStmt=nil;
    if (sqlite3_open([DBpath UTF8String], &database) == SQLITE_OK)
    {
        if(deleteStmt == nil)
        {
            const char *sql = "delete from DocList where pk_doc_id = ?";
            if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
                return NO;
        }
        
        //When binding parameters, index starts from 1 and not zero.
        sqlite3_bind_int(deleteStmt, 1, [idDoc integerValue]);
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
            return NO;
        sqlite3_reset(deleteStmt);
    }
    sqlite3_close(database);
    return YES;
}
@end
