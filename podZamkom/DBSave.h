#import "DBadapter.h"

@interface DBadapter (DBSave)

-(BOOL)SaveNote: (Note *) note;
-(BOOL)SaveLogin: (Login *) login;
-(BOOL)SaveCreditCard: (CreditCard*)creditCard;

@end
