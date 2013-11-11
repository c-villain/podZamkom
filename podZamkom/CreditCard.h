//
//  CreditCard.h
//  Под замком
//
//  Created by Alexander Kraev on 31.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Document.h"
#import "CardType.h"
#import "CardColor.h"

@interface CreditCard : Document

@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *holder;
@property (nonatomic, assign) CardTypeEnum type;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *validThru;
@property (nonatomic, strong) NSString *cvc;
@property (nonatomic, strong) NSString *pin;
@property (nonatomic, assign) CardColorEnum color;
@property (nonatomic, strong) NSString *comments;

@end
