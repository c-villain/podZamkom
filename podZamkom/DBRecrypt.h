#import "DBlib.h"

@interface DBadapter (DBRecrypt)

+(BOOL)DBRecrypt: (NSString *) oldPassword;

@end