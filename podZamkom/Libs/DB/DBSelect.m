#import "DBSelect.h"

@implementation DBadapter (DBSelect)

+(Document *) DBSelect: (Document *)doc withKey: (NSString *)key
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    switch (doc.docType)
    {
        case NoteDoc:
            return [dbAdapter GetNoteDocById:(int)doc.idDoc withKey: key];
            break;
        case CardDoc:
            return [dbAdapter GetCreditCardDocById:(int)doc.idDoc withKey: key];
            break;
        case LoginDoc:
            return [dbAdapter GetLoginDocById:(int)doc.idDoc withKey: key];
            break;
        case BankAccountDoc:
            return [dbAdapter GetBankAccountDocById:(int)doc.idDoc withKey: key];
            break;
        case PassportDoc:
            return [dbAdapter GetPassportDocById:(int)doc.idDoc withKey: key];
            break;
        default:
            return nil;
    }

}

+(Document *) DBSelect: (Document *)doc
{
    return [self DBSelect:doc withKey:[Security getPassword]];
}

-(Document *) SelectDocument: (Document *)doc
{
    return [DBadapter DBSelect:doc withKey:[Security getPassword]];
}
/*
     Login (pk_login_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, url BLOB, user_name BLOB, password BLOB, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id))
     */
-(Login *) GetLoginDocById: (int) idDoc withKey: (NSString *)key
{
    Login * login = [Login new];
    login.docType = LoginDoc;
    login.idDocList = idDoc;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_login_id, url, user_name, password, comments from Login where fk_doc_id = %d", idDoc];
    const char *query_stmt = [querySQL UTF8String];
        
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                login.idDoc = sqlite3_column_int(statement, 0);
                
                login.url = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] withKey: key];
                
                login.login = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] withKey: key];
                    
                login.password = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] withKey: key];
                login.comment = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] withKey: key];
                
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return login;
}
    /*
     Note (pk_note_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, \
     content BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id))
     */
-(Note *) GetNoteDocById: (int) idDoc withKey: (NSString *)key
{
        Note * note = [Note new];
        note.docType = NoteDoc;
        note.idDocList = idDoc;
        sqlite3 *db;
        sqlite3_stmt *statement;
        NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_note_id, title, content from Note where fk_doc_id = %d", idDoc];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
        {
            if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    note.idDoc = sqlite3_column_int(statement, 0);
                    
                    note.title = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] withKey: key];
                    
                    note.content = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] withKey: key];
                }
                sqlite3_finalize(statement);
            }
            else
                return nil;
        }
        sqlite3_close(db);
        return note;
}
/*
CreditCard (pk_card_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, bank BLOB, holder BLOB, card_type INTEGER, number BLOB, validThru BLOB, cvc BLOB, pin BLOB, card_color INTEGER, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id)
*/
-(CreditCard *) GetCreditCardDocById: (int) idDoc withKey: (NSString *)key
{
    CreditCard * creditCardDoc = [CreditCard new];
    creditCardDoc.docType = CardDoc;
    creditCardDoc.idDocList = idDoc;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_card_id, bank, holder, card_type, number, validThru, cvc, pin, card_color, comments from CreditCard where fk_doc_id = %d", idDoc];
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                creditCardDoc.idDoc = sqlite3_column_int(statement, 0);
                
                creditCardDoc.bank = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] withKey: key];
                
                creditCardDoc.holder = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] withKey: key];
                
                creditCardDoc.type = sqlite3_column_int(statement, 3);
                
                creditCardDoc.number = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] withKey: key];
                
                creditCardDoc.validThru = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] withKey: key];
                
                creditCardDoc.cvc = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] withKey: key];
                
                creditCardDoc.pin = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] withKey: key];
                
                creditCardDoc.color = sqlite3_column_int(statement, 8);
                creditCardDoc.comments = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] withKey: key];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return creditCardDoc;
}

-(BankAccount *) GetBankAccountDocById: (int) idDoc withKey: (NSString *)key
{
    BankAccount * bankAccountDoc = [BankAccount new];
    bankAccountDoc.docType = BankAccountDoc;
    bankAccountDoc.idDocList = idDoc;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_account_id, bank, account_number, currency_type, bik, correspond_number, inn, kpp, comments from BankAccount where fk_doc_id = %d", idDoc];
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                bankAccountDoc.idDoc = sqlite3_column_int(statement, 0);
                
                bankAccountDoc.bank = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] withKey: key];
                
                bankAccountDoc.accountNumber = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] withKey: key];
                
                bankAccountDoc.curType = sqlite3_column_int(statement, 3);
                
                bankAccountDoc.bik = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] withKey: key];
                
                bankAccountDoc.corNumber = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] withKey: key];
                
                bankAccountDoc.inn = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] withKey: key];
                
                bankAccountDoc.kpp = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] withKey: key];
                
                bankAccountDoc.comments = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] withKey: key];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return bankAccountDoc;
}


-(Passport *) GetPassportDocById: (int) idDoc withKey: (NSString *)key
{
    Passport * passportDoc = [Passport new];
    passportDoc.docType = PassportDoc;
    passportDoc.idDocList = idDoc;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_passport_id, name, country, number, department, date_of_issue, department_code, holder, birth_date, birth_place from Passport where fk_doc_id = %d", idDoc];
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                passportDoc.idDoc = sqlite3_column_int(statement, 0);
                
                passportDoc.docName = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] withKey: key];
                
                passportDoc.country = sqlite3_column_int(statement, 2);
                
                passportDoc.number = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] withKey: key];
                
                passportDoc.department = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] withKey: key];
                
                passportDoc.issueDate = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] withKey: key];
                
                passportDoc.departmentCode = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] withKey: key];
                
                passportDoc.holder = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] withKey: key];
                
                passportDoc.birthDate = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] withKey: key];
                passportDoc.birthPlace = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] withKey: key];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return passportDoc;
}
    
@end
