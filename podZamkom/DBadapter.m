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
CREATE  TABLE IF NOT EXISTS Passport (pk_passport_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, name BLOB, country INTEGER, number BLOB, department BLOB, date_of_issue BLOB, department_code BLOB, holder BLOB, birth_date BLOB, birth_place BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id) );"

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
    const char *insert_stmt = "INSERT INTO DocList(doc_type, date_of_creation) VALUES(?,?)";
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

/*
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
*/
/*
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
*/

/*
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
*/
/*
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
*/

//для главного экрана для каждого из документов ищет, что показать в разделе название документа
-(NSString *)getDocumentName:(int)docId withDocType:(DocTypeEnum)docType
{
    sqlite3_stmt *statement;
    NSString *querySQL;
    NSString *docName;
    
    switch (docType)
    {
        case NoteDoc:
            querySQL = [NSString stringWithFormat: @"SELECT title FROM Note WHERE fk_doc_id = %d", docId];
            break;
        case CardDoc:
            querySQL = [NSString stringWithFormat: @"SELECT bank FROM CreditCard WHERE fk_doc_id = %d", docId];
            break;
        case PassportDoc:
            querySQL = [NSString stringWithFormat: @"SELECT name FROM Passport WHERE fk_doc_id = %d", docId];
            break;
        case BankAccountDoc:
            querySQL = [NSString stringWithFormat: @"SELECT bank FROM BankAccount WHERE fk_doc_id = %d", docId];
            break;
        case LoginDoc:
            querySQL = [NSString stringWithFormat: @"SELECT url FROM Login WHERE fk_doc_id = %d", docId];
            break;
        default:
            break;
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
-(void)setDocImage:(Document*)doc withDocType:(DocTypeEnum)docType
{
    switch (docType)
    {
        case NoteDoc:
            doc.imageFile = @"addNotes.png";
            break;
        case CardDoc:
            doc.imageFile = @"addCredit.png";
            break;
        case PassportDoc:
            break;
        case BankAccountDoc:
            break;
        case LoginDoc:
            doc.imageFile = @"addLogin.png";
            break;
        default:
            break;
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
                document.idDoc = sqlite3_column_int(statement, 0);
                
                document.docType = sqlite3_column_int(statement, 1);
                
                document.docName = [self getDocumentName:document.idDoc withDocType:document.docType];
                
                document.detail = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                [self setDocImage:document withDocType:document.docType];

                [documents addObject:document];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return documents;
}

//удаляет выбранный по id документ из базы
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
