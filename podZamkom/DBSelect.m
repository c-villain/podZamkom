#import "DBSelect.h"

@implementation DBadapter (DBSelect)

    /*
     Login (pk_login_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, \
     url BLOB, user_name BLOB, password BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id)
     */
-(Login *) GetLoginDocById: (NSString *) idDoc
{
        Login * loginDoc = [Login new];
        sqlite3 *db;
        sqlite3_stmt *statement;
        NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_login_id, url, user_name, password from Login where fk_doc_id = %d", [idDoc integerValue]];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
        {
            if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    loginDoc.idDoc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    
                    loginDoc.url = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                    
                    loginDoc.login = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
                    
                    loginDoc.password = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
                    
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(db);
        return loginDoc;
}
    /*
     Note (pk_note_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, \
     content BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id))
     */
-(Note *) GetNoteDocById: (NSString *) idDoc
{
        Note * noteDoc = [Note new];
        sqlite3 *db;
        sqlite3_stmt *statement;
        NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_note_id, title, content from Note where fk_doc_id = %d", [idDoc integerValue]];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
        {
            if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    noteDoc.idDoc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    
                    noteDoc.title = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                    
                    noteDoc.content = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(db);
        return noteDoc;
}
/*
CreditCard (pk_card_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, fk_doc_id INTEGER, title BLOB, name BLOB, surname BLOB, fk_type_id INTEGER, number BLOB, expDate BLOB, cvc BLOB, pin BLOB, bank BLOB, phone BLOB, word BLOB, url BLOB, login BLOB, password BLOB, creditLimit BLOB, note BLOB, FOREIGN KEY(fk_doc_id) REFERENCES DocList (pk_doc_id), FOREIGN KEY(fk_type_id) REFERENCES CardType (pk_type_id));
*/
-(CreditCard *) GetCreditCardDocById: (NSString *) idDoc
{
    CreditCard * creditCardDoc = [CreditCard new];
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_card_id, fk_type_id, title, name, surname, number, expDate, cvc, pin, bank, phone, word, url, login, password, creditLimit, note from CreditCard where fk_doc_id = %d", [idDoc integerValue]];
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                creditCardDoc.idDoc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                creditCardDoc.type = [self GetCardTypeByTypeId:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]]; //здесь получаем тип карты
                
                creditCardDoc.docName = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
//                TODO!
                /*
                creditCardDoc.name = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
                
                creditCardDoc.surname = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)]];
                
                creditCardDoc.number = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)]];
                
                creditCardDoc.expDate = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)]];
                
                creditCardDoc.cvc = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)]];
                
                creditCardDoc.pin = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)]];
                
                creditCardDoc.bank = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)]];
                
                creditCardDoc.phone = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)]];
                
                creditCardDoc.word = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)]];
                
                creditCardDoc.url = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)]];
                
                creditCardDoc.login = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)]];
                
                creditCardDoc.password = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)]];
                
                creditCardDoc.limit = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)]];
                
                creditCardDoc.notes = [FBEncryptorAES decryptString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)]];
                */
                
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return creditCardDoc;
}

-(CardType *) GetCardTypeByTypeId: (NSString *) idCardType
{
    CardType * cardType = [CardType new];
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT type from CardType where pk_type_id = %d", [idCardType integerValue]];
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                cardType.name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                if ([cardType.name isEqualToString:@"VISA"])
                {
                    cardType.image = @"visa.png";
                    cardType.enumObject = Visa;
                }

                if ([cardType.name isEqualToString:@"VISA Electron"])
                {
                    cardType.image = @"visaelectron.png";
                    cardType.enumObject = VisaElectron;
                }

                if ([cardType.name isEqualToString:@"Mastercard"])
                {
                    cardType.image = @"mastercard.png";
                    cardType.enumObject = Mastercard;
                }

                if ([cardType.name isEqualToString:@"Maestro"])
                {
                    cardType.image = @"maestro.png";
                    cardType.enumObject = Maestro;
                }

                if ([cardType.name isEqualToString:@"Cirrus"])
                {
                    cardType.image = @"cirrus.png";
                    cardType.enumObject = Cirrus;
                }

                if ([cardType.name isEqualToString:@"Discover"])
                {
                    cardType.image = @"discover.png";
                    cardType.enumObject = Discover;
                }

                if ([cardType.name isEqualToString:@"JCB"])
                {
                    cardType.image = @"jcb.png";
                    cardType.enumObject = JCB;
                }

                if ([cardType.name isEqualToString:@"Carte Blanche"])
                {
                    cardType.image = @"cb.png";
                    cardType.enumObject = CarteBlanche;
                }

                if ([cardType.name isEqualToString:@"American Express"])
                {
                    cardType.image = @"aex.png";
                    cardType.enumObject = AmericanExpress;
                }

                if ([cardType.name isEqualToString:@"UnionPay"])
                {
                    cardType.image = @"unionPay.png";
                    cardType.enumObject = UnionPay;
                }

                if ([cardType.name isEqualToString:@"Laser"])
                {
                    cardType.image = @"laser.png";
                    cardType.enumObject = Laser;
                }

                if ([cardType.name isEqualToString:@"Diners Club"])
                {
                    cardType.image = @"dinersclub.png";
                    cardType.enumObject = DinersClub;
                }
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return cardType;
}
@end
