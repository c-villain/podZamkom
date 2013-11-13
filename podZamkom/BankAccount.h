//
//  BankAccount.h
//  podZamkom
//
//  Created by Alexander Kraev on 11.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Document.h"
#import "CurrencyType.h"

@interface BankAccount : Document

@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *accountNumber; //номер счета
@property (nonatomic, assign) CurrencyTypeEnum curType; //тип валюты
@property (nonatomic, strong) NSString *bik; //БИК
@property (nonatomic, strong) NSString *corNumber; //кор счет
@property (nonatomic, strong) NSString *inn; //ИНН
@property (nonatomic, strong) NSString *kpp;
@property (nonatomic, strong) NSString *comments;

@end
