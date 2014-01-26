#import "DBRecrypt.h"

@implementation DBadapter(DBRecrypt)

+(BOOL)DBRecryptWithPassword: (NSString *) password
{
    DBadapter *db = [[DBadapter alloc] init];
    return [db DbRecryptWithPassword:password];
}

-(BOOL)DbRecryptWithPassword: (NSString *) password
{
    NSArray *documents = [DBadapter ReadData]; //читаем данные старым паролем

    NSUInteger docCount = documents.count;
    CGFloat progress = 0.0;
    for (NSUInteger docNum = 0; docNum < docCount; docNum ++)
    {
        progress = (CGFloat) (docNum + 1)/ (CGFloat)docCount;
        Document *doc = [documents objectAtIndex:docNum];
        doc = [DBadapter DBSelect:doc withPhotos:YES];
        if (![DBadapter DBSave:doc withKey:password]) //обновляем данные с новым паролем, но пока еще не сохраненным в цепочке
            return NO;
        if ([self.recryptDelegate respondsToSelector:@selector(RowWasProcessed:)])
        {
            [self.recryptDelegate RowWasProcessed:progress];
        }
    }
    return YES;
}




@end