
//
//  Created by Alexander Kraev on 04.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface Security : NSObject

+(void)savePassword:(NSString*)password;
+(NSString*)getPassword;

@end
