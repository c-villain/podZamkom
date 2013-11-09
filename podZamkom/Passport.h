//
//  Passport.h
//  podZamkom
//
//  Created by Alexander Kraev on 05.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Document.h"

@interface Passport : Document

@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *issueDate;
@property (nonatomic, strong) NSString *departmentCode;
@property (nonatomic, strong) NSString *personName;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *birthPlace;

@end
