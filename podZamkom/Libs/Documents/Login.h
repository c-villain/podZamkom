//
//  Login.h
//  Под замком
//
//  Created by Alexander Kraev on 25.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"

@interface Login : Document

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *comment;

@end
