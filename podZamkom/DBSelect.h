#import "DBadapter.h"

@interface DBadapter (DBSelect)

-(Login *) GetLoginDocById: (int) idDoc;
-(Note *) GetNoteDocById: (int) idDoc;
-(CreditCard *) GetCreditCardDocById: (int) idDoc;
-(BankAccount *) GetBankAccountDocById: (int) idDoc;
-(Passport *) GetPassportDocById: (int) idDoc;

@end