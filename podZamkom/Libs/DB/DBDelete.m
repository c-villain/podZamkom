//
//  DBDelete.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//
//
//  DBDelete.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBDelete.h"

@implementation DBadapter (DBDelete)

+(BOOL)DeleteDocument: (Document *) doc
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    return [dbAdapter DeleteDocument:doc];
}

+(BOOL)DeleteAllDocs
{
    NSArray *documents = [DBadapter ReadData]; //читаем данные старым паролем
    NSUInteger docCount = documents.count;
    
    for (NSUInteger docNum = 0; docNum < docCount; docNum ++)
    {
        Document *doc = [documents objectAtIndex:docNum];
        doc = [DBadapter DBSelect:doc withPhotos:YES];
        doc.idDoc = doc.idDocList;
        if (![DBadapter DeleteDocument:doc])
            return NO;
    }
    return YES;
}

-(BOOL)DeleteDocument: (Document *) doc
{
    sqlite3_stmt *statement;
    const char *delete_stmt;
    switch (doc.docType) {
        case NoteDoc:
            delete_stmt = "Delete from Note where fk_doc_id = ?";
            break;
        case CardDoc:
            delete_stmt = "Delete from CreditCard where fk_doc_id = ?";
            break;
        case LoginDoc:
            delete_stmt = "Delete from Login where fk_doc_id = ?";
            break;
        case BankAccountDoc:
            delete_stmt = "Delete from BankAccount where fk_doc_id = ?";
            break;
        case PassportDoc:
            delete_stmt = "Delete from Passport where fk_doc_id = ?";
            break;
        default:
            break;
    }
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    if (![self DeletePhotos:doc])
        return NO;
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int64(statement, 1, doc.idDocList);
            sqlite3_bind_int64(statement, 2, doc.idDocList);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                if ([dbAdapter DeleteDocumentFromList:doc] && [dbAdapter DeletePhotos:doc]) {
                    return YES;
                }
            }
        }
    }
    sqlite3_close(db);
    return NO;
}

-(BOOL)DeleteDocumentFromList: (Document *) doc
{
    sqlite3_stmt *statement;
    const char *delete_stmt;
    int64_t idDocList = doc.idDocList;
    delete_stmt = "Delete from DocList where pk_doc_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int64(statement, 1, idDocList);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
        }
    }
    sqlite3_close(db);
    return NO;
}

+(BOOL)DeletePhotos: (Document *) doc
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    return [dbAdapter DeletePhotos:doc];
}

-(BOOL)DeletePhotos: (Document *) doc
{
    sqlite3_stmt *statement;
    const char *delete_stmt;
    delete_stmt = "Delete from Photos where fk_doc_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int64(statement, 1, doc.idDocList);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
        }
    }
    sqlite3_close(db);
    return NO;
}

@end