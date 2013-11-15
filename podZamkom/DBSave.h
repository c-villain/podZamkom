#import "DBadapter.h"
#import "DBUpdate.h"

@interface DBadapter (DBSave)

+(BOOL)DBSave:(Document *)doc; //главная функция

+(BOOL)SaveDocument: (Document *) doc;

-(BOOL)SaveNote: (Note *) note;
-(BOOL)SaveLogin: (Login *) login;
-(BOOL)SaveCreditCard: (CreditCard*)creditCard;
-(BOOL)SavePassport: (Passport *)passport;
-(BOOL)SaveBankAccount:(BankAccount *)bankAccount;

@end
