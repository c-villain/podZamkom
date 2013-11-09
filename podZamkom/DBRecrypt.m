#import "DBRecrypt.h"

@implementation DBadapter (DBRecrypt)

+(BOOL)RecryptDB: (NSString *) oldPassword
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    NSArray *documents = [dbAdapter ReadData];
    NSUInteger docCount = documents.count;
    
    for (NSUInteger docNum = 0; docNum < docCount; docNum ++)
    {
        Document *doc = [documents objectAtIndex:docNum];
        
        NSString *docType = [dbAdapter getDocTypeByDocId:doc.idDoc];
        
        if ([docType isEqual: @"Заметка"])
        {
//            Note *noteDoc = [Note new];
//            noteDoc = [dbAdapter GetNoteDocById:doc.idDoc withPassword:oldPassword];
//            [dbAdapter UpdateNote:noteDoc];
            
        }
//        else if ([docType isEqual: @"Логин"])
//        {
//            Login *loginDoc = [Login new];
//            loginDoc = [dbAdapter GetLoginDocById:doc.idDoc];
//            
//        }
//        else if ([docType isEqual: @"Кредитка"])
//        {
//            CreditCard *creditCard = [CreditCard new];
//            creditCard = [dbAdapter GetCreditCardDocById:doc.idDoc];
//        }
    }
    return YES;
}

@end