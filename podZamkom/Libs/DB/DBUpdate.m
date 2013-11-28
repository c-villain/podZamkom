//
//  DBUpdate.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBUpdate.h"

@implementation DBadapter (DBUpdate)

+(BOOL)UpdateDocument: (Document *) doc withKey:(NSString *) key
{
    DBadapter *db = [[DBadapter alloc] init];
    switch (doc.docType)
    {
        case NoteDoc:
            return [db UpdateNote:(Note *)doc withKey: key];
            break;
        case CardDoc:
            return [db UpdateCreditCard:(CreditCard *)doc withKey: key];
            break;
        case PassportDoc:
            return [db UpdatePassport:(Passport *)doc withKey: key];
            break;
        case BankAccountDoc:
            return [db UpdateBankAccount:(BankAccount *)doc withKey: key];
            break;
        case LoginDoc:
            return [db UpdateLogin:(Login *)doc withKey: key];
            break;
        default:
            break;
    }
}

-(BOOL)UpdateNote: (Note *) note withKey:(NSString *) key//Yes - save to DB, no - not saved
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Note Set title = ? , content = ?  where pk_note_id = ?";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL) == SQLITE_OK);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:note.title withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:note.content withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 3, note.idDoc);
//            sqlite3_bind_int64(statement, 3, note.idDoc);

            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
            else
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
    }
    sqlite3_close(db);
    return NO;
}

-(BOOL)UpdateLogin: (Login *) login withKey:(NSString *) key
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Login Set url = ?, user_name = ?, password = ?, comments = ? where pk_login_id = ?";

    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:login.url withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:login.login withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:login.password withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:login.comment withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 5, login.idDoc);
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


-(BOOL)UpdateCreditCard:(CreditCard*) creditCard withKey:(NSString *) key
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update CreditCard Set bank = ?, holder = ?, card_type = ?, number = ? , validThru = ? , cvc = ? , pin = ? , card_color = ? , comments = ? where pk_card_id = ?";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL) == SQLITE_OK);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:creditCard.bank withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:creditCard.holder withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 3, creditCard.type);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:creditCard.number withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:creditCard.validThru withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:creditCard.cvc withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:creditCard.pin withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 8, creditCard.color);
            sqlite3_bind_text(statement, 9, [[FBEncryptorAES encryptString:creditCard.comments withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 10, creditCard.idDoc);
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
            else
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
    }
    sqlite3_close(db);
    return NO;
}


-(BOOL)UpdatePassport: (Passport *)passport withKey:(NSString *) key
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Passport Set name = ?, country = ?, number = ?, department = ? , date_of_issue = ? , department_code = ? , holder = ? , birth_date = ? , birth_place = ? where pk_passport_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL) == SQLITE_OK);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:passport.docName withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 2, passport.country);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:passport.number withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:passport.department withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:passport.issueDate withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:passport.departmentCode withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:passport.holder withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:passport.birthDate withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 9, [[FBEncryptorAES encryptString:passport.birthPlace withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 10, passport.idDoc);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
            else
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
    }
    sqlite3_close(db);
    return NO;
    
}

-(BOOL)UpdateBankAccount:(BankAccount *)bankAccount withKey:(NSString *) key
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update BankAccount Set bank = ?, account_number = ?, currency_type = ?, bik = ? , correspond_number = ? , inn = ? , kpp = ? , comments = ? where pk_account_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:bankAccount.bank withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:bankAccount.accountNumber withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 3, bankAccount.curType);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:bankAccount.bik withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:bankAccount.corNumber withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:bankAccount.inn withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:bankAccount.kpp withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:bankAccount.comments withKey:key] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(statement, 9, bankAccount.idDoc);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return YES;
            }
            else
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
    }
    sqlite3_close(db);
    return NO;
}
@end