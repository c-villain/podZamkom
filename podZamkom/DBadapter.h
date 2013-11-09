//
//  DBadapter.h
//  Под замком
//
//  Created by Alexander Kraev on 13.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FBEncryptorAES.h"
#import "DocumentLib.h"

@interface DBadapter : NSObject
{
    NSString *DBname;
    NSString *DBpath;
}
-(id)init;
-(NSArray *)ReadData;
-(BOOL)DeleteDocFromDB:(NSString *)idDoc;


-(NSString *)getDocTypeByTypeId:(int)idType;
-(NSString *)getDocTypeByDocId:(NSString *)idDoc;

-(int)getIdOfDocType:(NSString*)docType;
-(NSString *)getDocumentName:(int)docId withDocType:(int)idDocType;

-(int)insertIntoDocList:(int)docType;
-(int)getCardTypeIdByCardType:(CardType *)cardType;

@end
