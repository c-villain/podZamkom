#import "DBSelect.h"

@implementation DBadapter (DBSelect)

+(Document *) DBSelect: (Document *)doc
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    switch (doc.docType)
    {
        case NoteDoc:
            return [dbAdapter GetNoteDocById:(int)doc.idDoc];
            break;
        case CardDoc:
            return [dbAdapter GetCreditCardDocById:(int)doc.idDoc];
            break;
        case LoginDoc:
            return [dbAdapter GetLoginDocById:(int)doc.idDoc];
            break;
        case BankAccountDoc:
            return [dbAdapter GetBankAccountDocById:(int)doc.idDoc];
            break;
        case PassportDoc:
            return [dbAdapter GetPassportDocById:(int)doc.idDoc];
            break;
        default:
            return nil;
    }
}

/*
     Login (pk_login_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, url BLOB, user_name BLOB, password BLOB, comments BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id))
     */
-(Login *) GetLoginDocById: (int) idDoc
{
    Login * login = [Login new];
    login.docType = LoginDoc;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_login_id, url, user_name, password, comments from Login where fk_doc_id = %d", idDoc];        const char *query_stmt = [querySQL UTF8String];
        
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                login.idDoc = sqlite3_column_int(statement, 0);
                
                login.url = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
                
                login.login = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
                    
                login.password = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
                login.comment = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)]];
                
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
-(Note *) GetNoteDocById: (int) idDoc
{
        Note * note = [Note new];
        note.docType = NoteDoc;
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
                    
                    note.title = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                    
                    note.content = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
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
-(CreditCard *) GetCreditCardDocById: (int) idDoc
{
    CreditCard * creditCardDoc = [CreditCard new];
    creditCardDoc.docType = CardDoc;
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
                
                creditCardDoc.bank = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ];
                
                creditCardDoc.holder = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] ];
                
                creditCardDoc.type = sqlite3_column_int(statement, 3);
                
                creditCardDoc.number = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] ];
                
                creditCardDoc.validThru = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] ];
                
                creditCardDoc.cvc = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] ];
                
                creditCardDoc.pin = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] ];
                
                creditCardDoc.color = sqlite3_column_int(statement, 8);
                creditCardDoc.comments = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] ];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return creditCardDoc;
}

-(BankAccount *) GetBankAccountDocById: (int) idDoc
{
    BankAccount * bankAccountDoc = [BankAccount new];
    bankAccountDoc.docType = BankAccountDoc;
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
                
                bankAccountDoc.bank = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ];
                
                bankAccountDoc.accountNumber = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] ];
                
                bankAccountDoc.curType = sqlite3_column_int(statement, 3);
                
                bankAccountDoc.bik = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] ];
                
                bankAccountDoc.corNumber = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] ];
                
                bankAccountDoc.inn = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] ];
                
                bankAccountDoc.kpp = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] ];
                
                bankAccountDoc.comments = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] ];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return bankAccountDoc;
}


-(Passport *) GetPassportDocById: (int) idDoc
{
    Passport * passportDoc = [Passport new];
    passportDoc.docType = PassportDoc;
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
                
                passportDoc.docName = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ];
                
                passportDoc.country = sqlite3_column_int(statement, 2);
                
                passportDoc.number = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] ];
                
                passportDoc.department = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] ];
                
                passportDoc.issueDate = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] ];
                
                passportDoc.departmentCode = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] ];
                
                passportDoc.holder = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] ];
                
                passportDoc.birthDate = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] ];
                passportDoc.birthPlace = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] ];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return passportDoc;
}
    
@end
