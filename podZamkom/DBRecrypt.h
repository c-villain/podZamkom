#import "DBlib.h"

@interface DBadapter (DBRecrypt)

+(BOOL)RecryptDB: (NSString *) oldPassword;

@end