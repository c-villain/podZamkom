//
//  DBUpdate.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 07.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBUpdate.h"

@implementation DBadapter (DBUpdate)

+(BOOL)UpdateDocument: (Document *) doc
{
    DBadapter *db = [[DBadapter alloc] init];
    
    BOOL result;
    switch (doc.docType)
    {
        case NoteDoc:
            result = [db UpdateNote:(Note *)doc];
            break;
        case CardDoc:
            result = [db UpdateCreditCard:(CreditCard *)doc];
            break;
        case PassportDoc:
            result = [db UpdatePassport:(Passport *)doc];
            break;
        case BankAccountDoc:
            result = [db UpdateBankAccount:(BankAccount *)doc];
            break;
        case LoginDoc:
            result = [db UpdateLogin:(Login *)doc];
            break;
        default:
            break;
    }
    return result;
}

-(BOOL)UpdateNote: (Note *) note //Yes - save to DB, no - not saved
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Note Set title = ? , content = ?  where pk_note_id = ?";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL) == SQLITE_OK);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:note.title] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:note.content] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 3, note.idDoc);

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

-(BOOL)UpdateLogin: (Login *) login
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Login Set url = ?, user_name = ?, password = ?, comments = ? where pk_login_id = ?";

    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:login.url] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:login.login] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:login.password] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:login.comment] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 5, login.idDoc);
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


-(BOOL)UpdateCreditCard:(CreditCard*) creditCard
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update CreditCard Set bank = ?, holder = ?, card_type = ?, number = ? validThru = ?  cvc = ?  pin = ?  card_color = ?  comments = ? where pk_card_id = ?";
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:creditCard.bank] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:creditCard.holder] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 3, creditCard.type);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:creditCard.number] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:creditCard.validThru] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:creditCard.cvc] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:creditCard.pin] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 8, creditCard.color);
            sqlite3_bind_text(statement, 9, [[FBEncryptorAES encryptString:creditCard.comments] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 10, creditCard.idDoc);
            
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


-(BOOL)UpdatePassport: (Passport *)passport
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update Passport Set name = ?, country = ?, number = ?, department = ? date_of_issue = ?  department_code = ?  holder = ?  birth_date = ?  birth_place = ? where pk_passport_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:passport.docName] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 2, passport.country);
            sqlite3_bind_text(statement, 3, [[FBEncryptorAES encryptString:passport.number] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:passport.department] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:passport.issueDate] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:passport.departmentCode] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:passport.holder] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:passport.birthDate] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 9, [[FBEncryptorAES encryptString:passport.birthPlace] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 10, passport.idDoc);
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

-(BOOL)UpdateBankAccount:(BankAccount *)bankAccount
{
    sqlite3_stmt *statement;
    const char *update_stmt = "Update BankAccount Set bank = ?, account_number = ?, currency_type = ?, bik = ? correspond_number = ?  inn = ?  kpp = ?  comments = ? where pk_account_id = ?";
    
    sqlite3 *db;
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        sqlite3_prepare_v2(db, update_stmt, -1, &statement, NULL);
        {
            sqlite3_bind_text(statement, 1, [[FBEncryptorAES encryptString:bankAccount.bank] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[FBEncryptorAES encryptString:bankAccount.accountNumber] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 3, bankAccount.curType);
            sqlite3_bind_text(statement, 4, [[FBEncryptorAES encryptString:bankAccount.bik] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[FBEncryptorAES encryptString:bankAccount.corNumber] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[FBEncryptorAES encryptString:bankAccount.inn] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[FBEncryptorAES encryptString:bankAccount.kpp] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[FBEncryptorAES encryptString:bankAccount.comments] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 9, docListRowId);
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