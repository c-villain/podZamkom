#import "DBadapter.h"

@interface DBadapter (DBSelect)

-(Login *) GetLoginDocById: (NSString *) idDoc;
-(Note *) GetNoteDocById: (NSString *) idDoc;
-(CreditCard *) GetCreditCardDocById: (NSString *) idDoc;

-(CardType *) GetCardTypeByTypeId: (NSString *) idCardType;
@end