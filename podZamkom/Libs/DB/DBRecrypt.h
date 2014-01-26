#import "DBlib.h"

@interface DBadapter (DBRecrypt)

+(BOOL)DBRecryptWithPassword: (NSString *) password;
-(BOOL)DbRecryptWithPassword: (NSString *) password;

@end