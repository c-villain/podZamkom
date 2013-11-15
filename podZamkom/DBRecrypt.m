#import "DBRecrypt.h"

@implementation DBadapter (DBRecrypt)

+(BOOL)DBRecrypt: (NSString *) oldPassword
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    NSArray *documents = [dbAdapter ReadData];
    NSUInteger docCount = documents.count;
    
    for (NSUInteger docNum = 0; docNum < docCount; docNum ++)
    {
        Document *doc = [documents objectAtIndex:docNum];
        doc = [DBadapter DBSelect:doc]; 
        [DBadapter DBSave:doc];
    }
    return YES;
}

@end