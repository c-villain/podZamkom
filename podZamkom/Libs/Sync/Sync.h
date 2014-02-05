//
//  Sync.h
//  podZamkom
//
//  Created by Alexander Kraev on 31.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Security.h"
#import "NSString+Hash.h"
#import "DBlib.h"

@interface Sync : NSObject
{
    NSString *BUname;
    NSString *BUpath;
}

+(void)CreateBackup;

@end
