#import "DBadapter.h"

@interface DBadapter (DBSave)

-(BOOL)SaveNote: (NSString*) title withContent: (NSString*) content;
-(BOOL)SaveLogin: (NSString*) url withLogin: (NSString*) login andPassword: (NSString*) password;
-(BOOL)SaveCreditCard: (CreditCard*)creditCard;

@end
