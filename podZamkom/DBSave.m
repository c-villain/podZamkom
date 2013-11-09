//
//  DBSave.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBSave.h"

@implementation DBadapter (DBSave)

-(BOOL)SaveNote: (NSString*) title withContent: (NSString*) content //Yes - save to DB, no - not saved
{
    sqlite3_stmt *statement;
    int typeid = [self getIdOfDocType:@"Заметка"];
    if (typeid == 0)
        return NO;
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
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:title] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:content] UTF8String], -1, SQLITE_TRANSIENT);
            
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

-(BOOL)SaveLogin: (NSString*) url withLogin: (NSString*) login andPassword: (NSString*) password
{
    sqlite3_stmt *statement;
    int typeid = [self getIdOfDocType:@"Логин"];
    if (typeid == 0)
        return NO;
    int docListRowId = [self insertIntoDocList:typeid];
    if (docListRowId == 0)
        return NO;
    
    const char *insert_stmt = "INSERT INTO Login(fk_doc_id, url, user_name, password) VALUES(?,?,?,?)";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docListRowId);
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:url] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:login] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:password] UTF8String], -1, SQLITE_TRANSIENT);
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
    int typeid = [self getIdOfDocType:@"Кредитка"];
    if (typeid == 0)
        return NO;
    
//    int cardtypeid = [self getCardTypeIdByCardType:creditCard.type];
    
    int docListRowId = [self insertIntoDocList:typeid];
    if (docListRowId == 0)
        return NO;
    
    const char *insert_stmt = "INSERT INTO CreditCard(fk_doc_id, title, name, surname, fk_type_id, number, expDate, cvc, pin, bank, phone, word, url, login, password, creditLimit, note) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_int(statement, 1, docListRowId);
            
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:creditCard.docName] UTF8String], -1, SQLITE_TRANSIENT);
//            TODO
            /*
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:creditCard.name] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:creditCard.surname] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 5, cardtypeid);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:creditCard.number] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:creditCard.expDate] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:creditCard.cvc] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 9, [[FBEncryptorAES encryptString:creditCard.pin] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 10, [[FBEncryptorAES encryptString:creditCard.bank] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 11, [[FBEncryptorAES encryptString:creditCard.phone] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 12, [[FBEncryptorAES encryptString:creditCard.word] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 13, [[FBEncryptorAES encryptString:creditCard.url] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 14, [[FBEncryptorAES encryptString:creditCard.login] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 15, [[FBEncryptorAES encryptString:creditCard.password] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 16, [[FBEncryptorAES encryptString:creditCard.limit] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 17, [[FBEncryptorAES encryptString:creditCard.notes] UTF8String], -1, SQLITE_TRANSIENT);*/
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