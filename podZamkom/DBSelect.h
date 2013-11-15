#import "DBadapter.h"

@interface DBadapter (DBSelect)

+(Document *) DBSelect: (Document *)doc;

-(Login *) GetLoginDocById: (int) idDoc;
-(Note *) GetNoteDocById: (int) idDoc;
-(CreditCard *) GetCreditCardDocById: (int) idDoc;
-(BankAccount *) GetBankAccountDocById: (int) idDoc;
-(Passport *) GetPassportDocById: (int) idDoc;

@end