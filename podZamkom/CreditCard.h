//
//  CreditCard.h
//  Под замком
//
//  Created by Alexander Kraev on 31.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Document.h"
#import "CardType.h"

@interface CreditCard : Document

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *surname;
@property (nonatomic, assign) CardType *type;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *expDate;
@property (nonatomic, strong) NSString *cvc;
@property (nonatomic, strong) NSString *pin;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *limit;
@property (nonatomic, strong) NSString *notes;

@end
