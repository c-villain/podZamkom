#import "DBadapter.h"
//#import "DocumentLib.h"

@interface DBadapter (DBSelect)

-(NSArray *) ReadData;
-(NSArray *)ReadDocsWithType:(DocTypeEnum)docType;
+(Document *) DBSelect: (Document *)doc withKey: (NSString *)key;
+(Document *) DBSelect: (Document *)doc;
-(Document *) SelectDocument: (Document *)doc;
-(UIView *) CreateViewWithImageForDocument:(Document *)doc;

-(Login *) GetLoginDocById: (int) idDocList withKey: (NSString *)key;
-(Note *) GetNoteDocById: (int) idDoc withKey: (NSString *)key;
-(CreditCard *) GetCreditCardDocById: (int) idDoc withKey: (NSString *)key;
-(BankAccount *) GetBankAccountDocById: (int) idDoc withKey: (NSString *)key;
-(Passport *) GetPassportDocById: (int) idDoc withKey: (NSString *)key;

@end