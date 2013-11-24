#import "DBadapter.h"

@interface DBadapter (DBSelect)

+(Document *) DBSelect: (Document *)doc withKey: (NSString *)key;
+(Document *) DBSelect: (Document *)doc;
-(Document *) SelectDocument: (Document *)doc;

-(Login *) GetLoginDocById: (int) idDoc withKey: (NSString *)key;
-(Note *) GetNoteDocById: (int) idDoc withKey: (NSString *)key;
-(CreditCard *) GetCreditCardDocById: (int) idDoc withKey: (NSString *)key;
-(BankAccount *) GetBankAccountDocById: (int) idDoc withKey: (NSString *)key;
-(Passport *) GetPassportDocById: (int) idDoc withKey: (NSString *)key;

@end