#import "DBadapter.h"

@interface DBadapter (DBUpdate)

+(BOOL)UpdateDocument: (Document *) doc;

-(BOOL)UpdateNote: (Note *) note;
-(BOOL)UpdateLogin: (Login *) login;
-(BOOL)UpdateCreditCard: (CreditCard*)creditCard;
-(BOOL)UpdatePassport: (Passport *)passport;
-(BOOL)UpdateBankAccount:(BankAccount *)bankAccount;
@end