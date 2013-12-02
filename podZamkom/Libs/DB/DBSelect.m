#import "DBSelect.h"

@implementation DBadapter (DBSelect)

//читает все данные из таблицы DocList
-(NSArray *)ReadData
{
    return [self selectDocumentswithType:nil];
}

-(NSArray *)ReadDocsWithType:(DocTypeEnum *)docType
{
    return [self selectDocumentswithType:docType];
}

-(NSArray *)selectDocumentswithType:(DocTypeEnum *)docType
{
    [self checkAndCreateDBFile];
    [self CreateDBTablesIfNotExists];
    NSString *querySQL = [NSString stringWithFormat: @"SELECT *from DocList"];
    if (docType != nil)
        querySQL = [querySQL stringByAppendingString:@" WHERE doc_type = ?"];
    NSMutableArray *documents = [[NSMutableArray alloc] init]; //массив документов
    sqlite3 *db;
    sqlite3_stmt *statement;
    const char *query_stmt = [querySQL UTF8String];
    
    if (sqlite3_open([DBpath UTF8String], &db)==SQLITE_OK)
    {
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL)== SQLITE_OK)
        {
            if (docType != nil)
                sqlite3_bind_int(statement, 1, *docType);
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Document *document = [Document new];
                document.idDocList = sqlite3_column_int(statement, 0);
                
                document.docType = sqlite3_column_int(statement, 1);
                
                document.dateOfCreation = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                document = [self SelectDocument:document];
                
                switch (document.docType)
                {
                    case NoteDoc:
                        document.docName = ((Note *)document).title;
                        document.detail = ((Note *)document).content;
                        break;
                    case CardDoc:
                        document.docName = ((CreditCard *)document).bank;
                        document.detail = ((CreditCard *)document).number;
                        
                        break;
                    case LoginDoc:
                        document.docName = ((Login *)document).url;
                        document.detail = ((Login *)document).login;
                        break;
                    case BankAccountDoc:
                        document.docName = ((BankAccount *)document).bank;
                        document.detail = ((BankAccount *)document).accountNumber;
                        break;
                    case PassportDoc:
                        document.docName = ((Passport *)document).docName;
                        document.detail = ((Passport *)document).number;
                        break;
                    default:
                        break;
                }
                
                document.viewWithImage = [self CreateViewWithImageForDocument:document];
                
                [documents addObject:document];
                
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(db);
    return documents;

}

-(UIView *) CreateViewWithImageForDocument:(Document *)doc
{
    UIView *view;
    
    switch (doc.docType)
    {
        case CardDoc:
        {
            //124 x 75
            CreditCard *card = (CreditCard *)doc;
            view=[[UIView alloc]initWithFrame:CGRectMake(0,0, 124, 75)];
            int stretchableCap = 20;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 124, 75)];
            UIImage *bg = [UIImage imageNamed:[CardColor getCardColorByType:card.color].image];
            UIImage *stretchIcon = [bg stretchableImageWithLeftCapWidth:stretchableCap topCapHeight:0];
            [imageView setImage:stretchIcon];
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            view.autoresizesSubviews = YES;
            [view addSubview:imageView];
            
            UIImageView *typeView = [[UIImageView alloc] initWithFrame:CGRectMake(92,52, 25, 15)];
            UIImage *type = [UIImage imageNamed: [CardType getCurrentCardByType:card.type].image];
            UIImage *typeIcon = [type stretchableImageWithLeftCapWidth:stretchableCap topCapHeight:0];
            [typeView setImage:typeIcon];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            view.autoresizesSubviews = YES;
            [view addSubview:typeView];
            
            UILabel *bank = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 114, 19)]; //(x,y,width,height)
            [bank setTextColor:[UIColor whiteColor]];
            bank.text = card.bank;
            [bank setBackgroundColor:[UIColor clearColor]];
            [bank setFont:[UIFont fontWithName: @"Menlo" size: 14.0f]];
            [view addSubview:bank];
            
            UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 119, 10)];
            [number setTextColor:[UIColor whiteColor]];
            number.text = card.number;
            [number setBackgroundColor:[UIColor clearColor]];
            [number setFont:[UIFont fontWithName: @"Menlo" size: 10.0f]];
            [view addSubview:number];
            
            UILabel *holder = [[UILabel alloc] initWithFrame:CGRectMake(5,55, 119, 10)];
            [holder setTextColor:[UIColor whiteColor]];
            holder.text = card.holder;
            [holder setBackgroundColor:[UIColor clearColor]];
            [holder setFont:[UIFont fontWithName: @"Menlo" size: 7.0f]];
            [view addSubview:holder];
            
            UILabel *valid = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 119, 10)];
            [valid setTextColor:[UIColor whiteColor]];
            valid.text = [@"Valid thru " stringByAppendingString:card.validThru];
            [valid setBackgroundColor:[UIColor clearColor]];
            [valid setFont:[UIFont fontWithName: @"Menlo" size: 5.0f]];
            [view addSubview:valid];
            break;
        }
        case PassportDoc:
        {
            //124 x 75
            Passport *passport = (Passport *)doc;
            view=[[UIView alloc]initWithFrame:CGRectMake(67,0, 57, 75)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 57, 75)];
            int stretchableCap = 20;
            UIImage *bg = [UIImage imageNamed:[Country getCurrentCountryByType:passport.country].passport];
            UIImage *stretchIcon = [bg stretchableImageWithLeftCapWidth:stretchableCap topCapHeight:0];
            [imageView setImage:stretchIcon];
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            view.autoresizesSubviews = YES;
            [view addSubview:imageView];
            break;
        }
        case LoginDoc:
        case BankAccountDoc:
        case NoteDoc:
            view = nil;
            break;
        default:
            break;
    }
    return view;
}

+(Document *) DBSelect: (Document *)doc withKey: (NSString *)key
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    Document *document = [Document new];
    switch (doc.docType)
    {
        case NoteDoc:
            document = [dbAdapter GetNoteDocById:(int)doc.idDocList withKey: key];
            break;
        case CardDoc:
            document =  [dbAdapter GetCreditCardDocById:(int)doc.idDocList withKey: key];
            break;
        case LoginDoc:
            document =  [dbAdapter GetLoginDocById:(int)doc.idDocList withKey: key];
            break;
        case BankAccountDoc:
            document =  [dbAdapter GetBankAccountDocById:(int)doc.idDocList withKey: key];
            break;
        case PassportDoc:
            document =  [dbAdapter GetPassportDocById:(int)doc.idDocList withKey: key];
            break;
        default:
            return nil;
    }
    document.dateOfCreation = doc.dateOfCreation;
    return document;
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
-(Login *) GetLoginDocById: (int) idDocList withKey: (NSString *)key
{
    Login * login = [Login new];
    login.docType = LoginDoc;
    login.idDocList = idDocList;
    sqlite3 *db;
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT pk_login_id, url, user_name, password, comments from Login where fk_doc_id = %d", idDocList];
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
