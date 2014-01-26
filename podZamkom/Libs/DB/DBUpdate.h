#import "DBadapter.h"
#import "DBDelete.h"

@interface DBadapter (DBUpdate)

+(BOOL)UpdateDocument: (Document *) doc withKey:(NSString *) key;

-(BOOL)UpdateNote: (Note *) note withKey:(NSString *) key;
-(BOOL)UpdateLogin: (Login *) login withKey:(NSString *) key;
-(BOOL)UpdateCreditCard: (CreditCard*)creditCard withKey:(NSString *) key;
-(BOOL)UpdatePassport: (Passport *)passport withKey:(NSString *) key;
-(BOOL)UpdateBankAccount:(BankAccount *)bankAccount withKey:(NSString *) key;

@end