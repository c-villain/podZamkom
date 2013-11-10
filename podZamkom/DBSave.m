//
//  DBSave.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBSave.h"

@implementation DBadapter (DBSave)

-(BOOL)SaveNote: (Note *) note //Yes - save to DB, no - not saved
{
    sqlite3_stmt *statement;
    int typeid = NoteDoc;
    int docListRowId = [self insertIntoDocList:typeid];
    if (docListRowId == 0)
        return NO;
    
    const char *insert_stmt = "INSERT INTO Note(fk_doc_id, title, content) VALUES(?,?,?)";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docListRowId);
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:note.title] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:note.content] UTF8String], -1, SQLITE_TRANSIENT);
            
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

-(BOOL)SaveLogin: (Login *) login
{
    sqlite3_stmt *statement;
    int typeid = LoginDoc;
    int docListRowId = [self insertIntoDocList:typeid];
    if (docListRowId == 0)
        return NO;
    
    const char *insert_stmt = "INSERT INTO Login(fk_doc_id, url, user_name, password, comments) VALUES(?,?,?,?,?)";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docListRowId);
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:login.url] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:login.login] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:login.password] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:login.comment] UTF8String], -1, SQLITE_TRANSIENT);
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


-(BOOL)SaveCreditCard:(CreditCard*) creditCard
{
    sqlite3_stmt *statement;
    int typeid = CardDoc;
    int docListRowId = [self insertIntoDocList:typeid];
    if (docListRowId == 0)
        return NO;

    const char *insert_stmt = "INSERT INTO CreditCard(fk_doc_id, bank, holder, card_type, number, validThru, cvc, pin, card_color, comments) VALUES(?,?,?,?,?,?,?,?,?,?)";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docListRowId);
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:creditCard.bank] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:creditCard.holder] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 4, creditCard.type.cardType);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:creditCard.number] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:creditCard.validThru] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:creditCard.cvc] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:creditCard.pin] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 9, creditCard.color.cardColor);
            sqlite3_bind_text(statement, 10, [[FBEncryptorAES encryptString:creditCard.comments] UTF8String], -1, SQLITE_TRANSIENT);
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