#import "DBRecrypt.h"

@implementation DBadapter (DBRecrypt)

+(BOOL)DBRecryptWithPassword: (NSString *) password
{
    DBadapter *dbAdapter = [[DBadapter alloc] init];
    NSArray *documents = [dbAdapter ReadData]; //читаем данные старым паролем
    NSUInteger docCount = documents.count;
    
    for (NSUInteger docNum = 0; docNum < docCount; docNum ++)
    {
        Document *doc = [documents objectAtIndex:docNum];
        doc = [DBadapter DBSelect:doc];
        if (![DBadapter DBSave:doc withKey:password]) //обновляем данные с новым паролем, но пока еще не сохраненным в цепочке
            return NO;
    }
    return YES;
}

@end