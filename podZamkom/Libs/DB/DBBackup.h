//
//  DBadapter_DBBackup.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.02.14.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "DBadapter.h"

@interface DBadapter (DBBackup)

int loadOrSaveDb(sqlite3 *pInMemory, const char *zFilename, int isSave);

@end