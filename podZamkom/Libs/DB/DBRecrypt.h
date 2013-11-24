#import "DBlib.h"

@interface DBadapter (DBRecrypt)

+(BOOL)DBRecryptWithPassword: (NSString *) password;

@end