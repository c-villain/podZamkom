//
//  DBadapter_DBDelete.h
//  podZamkom
//
//  Created by Alexander Kraev on 18.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBadapter.h"
#import "DBSelect.h"

@interface DBadapter (DBDelete)

+(BOOL)DeleteAllDocs;

+(BOOL)DeleteDocument: (Document *) doc;
-(BOOL)DeleteDocument: (Document *) doc;
+(BOOL)DeletePhotos: (Document *) doc;
-(BOOL)DeletePhotos: (Document *) doc;

@end
